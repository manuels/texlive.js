var Module = {};

Module['print'] = function(msg) {
  self['postMessage'](JSON.stringify({
    'command': 'stdout',
    'contents': msg
  }));
};

Module['printErr'] = function(msg) {
  self['postMessage'](JSON.stringify({
    'command': 'stderr',
    'contents': msg
  }));
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

Module['preInit'] = function() {};

var FS_getFile = function(filename) {
  var node = FS.analyzePath(filename);
  return node.object.contents;
}

var FS_deleteFile = function(filename) {
  return FS.deleteFile(filename);
}

self['onmessage'] = function(ev) {
  var data = JSON.parse(ev['data']);
  var args = data['arguments'];
  var res = undefined;

  switch(data['command']) {
    case 'run':
      res = run(args);
      break;
    case 'FS_createLazyFilesFromList':
      args.unshift(data['msg_id']);

      FS_createLazyFilesFromList.apply(this, args);
      break;
    break;
    case 'FS_getFile':
      res = FS_getFile.apply(this, args);
      break;
    case 'FS_deleteFile':
      FS_deleteFile.apply(this, args);
      res = true;
      break;
    break;
    case 'FS_createDataFile':
    case 'FS_createLazyFile':
    case 'FS_createFolder':
    case 'FS_createPath':
      res = Module[data['command']].apply(Module, args);
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
