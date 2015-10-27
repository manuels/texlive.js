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

    case 'FS_createDataFile': FS.createDataFile.apply(FS,args);res=true;break;
    case 'FS_createLazyFile': FS.createLazyFile.apply(FS,args);res=true;break;
    case 'FS_createFolder': FS.createFolder.apply(FS,args);res=true;break;
    case 'FS_createPath': FS.createPath.apply(FS,args);res=true;break;
    case 'FS_unlink': FS.unlink.apply(FS,args);res=true;break;
    case 'FS_readFile':
          var tmp=FS.readFile.apply(FS,args);
          var res='';
          var chunk = 8*1024;
          var i;
          for (i = 0; i < tmp.length/chunk; i++) {
            res += String.fromCharCode.apply(null, tmp.subarray(i*chunk, (i+1)*chunk));
          }
          res += String.fromCharCode.apply(null, tmp.subarray(i*chunk));
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
