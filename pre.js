var Module = {};
var is_browser = (typeof(self) !== "undefined" || typeof(window) !== "undefined");

if(is_browser) {
  Module['print'] = function(a) { self['postMessage'](JSON.stringify({'command': 'stdout', 'contents': a})); }
  Module['printErr'] = function(a) { self['postMessage'](JSON.stringify({'command': 'stderr', 'contents': a})); }
}


Module['preInit'] = function() {
  Module['FS_root'] = function() {
    return FS.root.contents;
  }
};

var FS_createLazyFilesFromList = function(msg_id, parent, list, parent_url, canRead, canWrite) {
  var xhr = new XMLHttpRequest();
  xhr.open('GET', list, false);
  xhr.responseType = 'text';

  xhr.onload = function() {
    var lines = this.response.split("\n");
    var path, pos, filename;
    for(var i in lines) {
      pos = lines[i].lastIndexOf("/");
      filename = lines[i].slice(pos+1);
      path = lines[i].slice(0, pos);

      if(filename === '.')
        Module['FS_createPath']('/', parent+path, canRead, canWrite);
      else
        if(filename.length > 0)
          Module['FS_createLazyFile'](parent+path, filename, parent_url+path+'/'+filename, canRead, canWrite);
    }

    self['postMessage'](JSON.stringify({
      'command': 'result',
      'result': 0,
      'msg_id': msg_id,
    }));
  };

  xhr.send();
};

var preparePRNG = function (argument) {
  if('egd-pool' in FS.root.contents['dev'].contents) {
    var rand_count = 0;
    var rand_contents = FS.root.contents['dev'].contents['egd-pool'].contents;
    var rand = new Uint8Array(rand_contents);
    FS.createDevice('/dev', 'urandom', function() { rand_count++; if(rand_count >= rand.length) { Module.print("Out of entropy!"); throw Error("Out of entropy"); } return rand[rand_count-1]; });
    FS.createDevice('/dev', 'random', function() { rand_count++; if(rand_count >= rand.length) { Module.print("Out of entropy!"); throw Error("Out of entropy"); } return rand[rand_count-1]; });
  }
}

self['onmessage'] = function(ev) {
  var data = JSON.parse(ev['data']);
  var args = data['arguments'];
  args = [].concat(args);
  var res = undefined;
  var fn;

  var cmd = data['command'];
  switch(cmd) {
    case 'run':
      shouldRunNow = true;
      preparePRNG();

      try {
        res = Module['run'](args);
      }
      catch(e) {
        self['postMessage'](JSON.stringify({'msg_id': data['msg_id'], 'command': 'error', 'message': e.toString()}));
        return;
      }
      self['postMessage'](JSON.stringify({'msg_id': data['msg_id'], 'command': 'success', 'result': res}));
      res = undefined;
    break;

    case 'FS_createLazyFilesFromList':
      args.unshift(data['msg_id']);

      res = FS_createLazyFilesFromList.apply(this, args);
    break;

    case 'FS_readFile':
    case 'FS_createDataFile':
    case 'FS_createLazyFile':
    case 'FS_createFolder':
    case 'FS_createPath':
    case 'FS_unlink':
      try {
        fn = cmd.substr(3);
        res = FS[fn].apply(FS, args);

        if(cmd === 'FS_readFile')
          res = String.fromCharCode.apply(null, res);
        else
          res = true;
      }
      catch(e) {
        res = false;
      }
    break;

    case 'set_TOTAL_MEMORY':
      Module.TOTAL_MEMORY = args[0];
      res = Module.TOTAL_MEMORY;
    break;
    case 'test':
    break;
  }

  if(typeof(res) !== 'undefined')
    self['postMessage'](JSON.stringify({
      'command': 'result',
      'result': res,
      'msg_id': data['msg_id'],
    }));
};
