var PDFTeX = function(url) {
  var worker = new Worker(url);
  var self = this;
  var initialized = false;

  self.onstdout = function(msg) {
    console.log(msg);
  }

  self.onstderr = function(msg) {
    console.log(msg);
  }


  worker.onmessage = function(ev) {
    var data = JSON.parse(ev.data);
    var msg_id;

    switch(data['command']) {
      case 'ready':
        onready.done(true);
        break;
      case 'stdout':
      case 'stderr':
        self['on'+data['command']](data['contents']);
        break;
      default:
        console.debug('< received', data);
        msg_id = data['msg_id'];
        promises[msg_id].done(data['result']);
    }
  }

  var onready = new promise.Promise();
  var promises = [];
  var chunkSize = undefined;

  var sendCommand = function(cmd) {
    var p = new promise.Promise();
    var msg_id = promises.push(p)-1;

    onready.then(function() {
      cmd['msg_id'] = msg_id;
      console.debug('> sending', cmd);
      worker.postMessage(JSON.stringify(cmd));
    });

    return p;
  };

  var determineChunkSize = function() {
    var size = 1024;
    var max = undefined; 
    var min = undefined;
    var delta = size;
    var success = true;
    var buf;

    while(Math.abs(delta) > 100) {
      if(success) {
        min = size;
        if(typeof(max) === 'undefined')
          delta = size;
        else
          delta = (max-size)/2;
      }
      else {
        max = size;
        if(typeof(min) === 'undefined')
          delta = -1*size/2;
        else
          delta = -1*(size-min)/2;
      }
      size += delta;

      success = true;
      try {
        buf = String.fromCharCode.apply(null, new Uint8Array(size));
        sendCommand({
          command: 'test',
          data: buf,
        });
      }
      catch(e) {
        success = false;
      }
    }

    return size;
  };


  var createCommand = function(command) {
    self[command] = function() {
      var args = [].concat.apply([], arguments);

      return sendCommand({
        'command':  command,
        'arguments': args,
      });
    }
  }
  createCommand('FS_createDataFile'); // parentPath, filename, data, canRead, canWrite
  createCommand('FS_getFile'); // filename
  createCommand('FS_deleteFile'); // filename
  createCommand('FS_createFolder'); // parent, name, canRead, canWrite
  createCommand('FS_createPath'); // parent, name, canRead, canWrite
  createCommand('FS_createLazyFile'); // parent, name, canRead, canWrite
  createCommand('FS_createLazyFilesFromList'); // parent, list, parent_url, canRead, canWrite

  var curry = function(obj, fn, args) {
    return function() {
      return obj[fn].apply(obj, args);
    }
  }

  self.compile = function(source_code) {
    if(typeof(chunkSize) === "undefined")
      chunkSize = determineChunkSize();

    var commands;
    if(initialized)
      commands = [
        curry(self, 'FS_deleteFile', ['/input.tex']),
      ];
    else
      commands = [
        curry(self, 'FS_createFolder', ['/', 'bin', true, true]),
        curry(self, 'FS_createDataFile', ['/bin', 'this.program', '', true, true]),
        curry(self, 'FS_createDataFile', ['/', 'input.tex', source_code, true, true]),
        curry(self, 'FS_createLazyFile', ['/', 'latex.fmt', 'latex.fmt', true, true]),
        curry(self, 'FS_createFolder', ['/bin/', 'share', true, true]),
        curry(self, 'FS_createLazyFile', ['/bin/', 'texmf.cnf', './texlive/texmf-dist/web2c/texmf.cnf', true, true]),
        curry(self, 'FS_createLazyFilesFromList', ['/', 'texlive.lst', './texlive/', true, true]),
      ];

    return promise.chain(commands).then(function() {
      initialized = true;
      return sendCommand({
        'command': 'run',
        'arguments': ['-output-format', 'pdf', '&latex', 'input.tex'],
      });
    });
  };
};
