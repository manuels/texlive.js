var detectPackages = function(code) {
  var rx = /\\usepackage(\[[^\]]+\])?{([^}]+)}/g;

  var res = rx.exec(code);
  var packages = [];
  while(res !== null) {
    packages.push(res[2]);
    res = rx.exec(code);
  }
  return packages;
};


var supported_packages = {
  "_basic_": [
    ['texlive/latex.fmt', '/', 'latex.fmt'],
    ['texlive/texmf-dist/tex/latex/base/article.cls', '/', 'article.cls'],

    ['texlive/texmf-dist/source/latex/base/size10.clo', '/', 'size10.clo'],
    ['texlive/texmf-dist/fonts/tfm/public/cm/cmr17.tfm', '/', 'cmr17.tfm'],
    ['texlive/texmf-dist/fonts/tfm/public/cm/cmr12.tfm', '/', 'cmr12.tfm'],
    ['texlive/texmf-dist/fonts/tfm/public/cm/cmr10.tfm', '/', 'cmr10.tfm'],
    ['texlive/texmf-dist/fonts/tfm/public/cm/cmr8.tfm', '/', 'cmr8.tfm'],
    ['texlive/texmf-dist/fonts/tfm/public/cm/cmr6.tfm', '/', 'cmr6.tfm'],

    ['texlive/texmf-dist/fonts/tfm/public/cm/cmbx12.tfm', '/', 'cmbx12.tfm'],
    ['texlive/texmf-dist/fonts/tfm/public/cm/cmti10.tfm', '/', 'cmti10.tfm'],

    ['texlive/texmf-dist/fonts/tfm/public/cm/cmmi12.tfm', '/', 'cmmi12.tfm'],
    ['texlive/texmf-dist/fonts/tfm/public/cm/cmmi8.tfm', '/', 'cmmi8.tfm'],
    ['texlive/texmf-dist/fonts/tfm/public/cm/cmmi6.tfm', '/', 'cmmi6.tfm'],

    ['texlive/texmf-dist/fonts/tfm/public/cm/cmsy10.tfm', '/', 'cmsy10.tfm'],
    ['texlive/texmf-dist/fonts/tfm/public/cm/cmsy8.tfm', '/', 'cmsy8.tfm'],
    ['texlive/texmf-dist/fonts/tfm/public/cm/cmsy6.tfm', '/', 'cmsy6.tfm'],

    ['texlive/texmf-dist/fonts/type1/public/amsfonts/cm/cmsy10.pfb', '/', 'cmsy10.pfb'],
    ['texlive/texmf-dist/fonts/type1/public/amsfonts/cm/cmsy7.pfb', '/', 'cmsy7.pfb'],
    ['texlive/texmf-dist/fonts/type1/public/amsfonts/cm/cmti10.pfb', '/', 'cmti10.pfb'],

    ['texlive/texmf-dist/source/latex/base/pdftex.map', '/', 'pdftex.map'],

    ['texlive/texmf-dist/fonts/type1/public/amsfonts/cm/cmr17.pfb', '/', 'cmr17.pfb'],
    ['texlive/texmf-dist/fonts/type1/public/amsfonts/cm/cmr12.pfb', '/', 'cmr12.pfb'],
    ['texlive/texmf-dist/fonts/type1/public/amsfonts/cm/cmr10.pfb', '/', 'cmr10.pfb'],
    ['texlive/texmf-dist/fonts/type1/public/amsfonts/cm/cmr8.pfb', '/', 'cmr8.pfb'],
    ['texlive/texmf-dist/fonts/type1/public/amsfonts/cm/cmr7.pfb', '/', 'cmr7.pfb'],
    ['texlive/texmf-dist/fonts/type1/public/amsfonts/cm/cmr6.pfb', '/', 'cmr6.pfb'],
    ['texlive/texmf-dist/fonts/type1/public/amsfonts/cm/cmbx12.pfb', '/', 'cmbx12.pfb'],
    ['texlive/texmf-dist/fonts/type1/public/amsfonts/cm/cmex10.pfb', '/', 'cmex10.pfb'],
    ['texlive/texmf-dist/fonts/type1/public/amsfonts/cm/cmmi10.pfb', '/', 'cmmi10.pfb'],
    ['texlive/texmf-dist/fonts/type1/public/amsfonts/cm/cmmi7.pfb', '/', 'cmmi7.pfb'],
  ],

  geometry: [
    ['texlive/texmf-dist/tex/latex/geometry/geometry.sty', '/', 'geometry.sty'],
    ['texlive/texmf-dist/tex/latex/graphics/keyval.sty', '/', 'keyval.sty'],
    ['texlive/texmf-dist/tex/generic/oberdiek/ifpdf.sty', '/', 'ifpdf.sty'],
    ['texlive/texmf-dist/tex/generic/oberdiek/ifvtex.sty', '/', 'ifvtex.sty'],
    ['texlive/texmf-dist/tex/generic/ifxetex/ifxetex.sty', '/', 'ifxetex.sty'],
  ],

  graphicx: [
    ['texlive/texmf-dist/tex/latex/graphics/graphicx.sty', '/', 'graphicx.sty'],
    ['texlive/texmf-dist/tex/latex/graphics/graphics.sty', '/', 'graphics.sty'],
    ['texlive/texmf-dist/tex/latex/graphics/trig.sty', '/', 'trig.sty'],
    ['texlive/texmf-dist/tex/latex/latexconfig/graphics.cfg', '/', 'graphics.cfg'],
    ['texlive/texmf-dist/tex/latex/pdftex-def/pdftex.def', '/', 'pdftex.def'],
    ['texlive/texmf-dist/tex/generic/oberdiek/infwarerr.sty', '/', 'infwarerr.sty'],
    ['texlive/texmf-dist/tex/generic/oberdiek/ltxcmds.sty', '/', 'ltxcmds.sty'],
    ['texlive/texmf-dist/tex/generic/oberdiek/pdftexcmds.sty', '/', 'pdftexcmds.sty' ],
    ['texlive/texmf-dist/tex/generic/oberdiek/ifluatex.sty', '/', 'ifluatex.sty' ],
    ['texlive/texmf-dist/tex/latex/oberdiek/epstopdf-base.sty', '/', 'epstopdf-base.sty' ],
    ['texlive/texmf-dist/tex/latex/oberdiek/grfext.sty', '/', 'grfext.sty' ],
    ['texlive/texmf-dist/tex/generic/oberdiek/kvdefinekeys.sty', '/', 'kvdefinekeys.sty' ],
    ['texlive/texmf-dist/tex/latex/oberdiek/kvoptions.sty', '/', 'kvoptions.sty' ],
    ['texlive/texmf-dist/tex/generic/oberdiek/kvsetkeys.sty', '/', 'kvsetkeys.sty' ],
    ['texlive/texmf-dist/tex/generic/oberdiek/etexcmds.sty', '/', 'etexcmds.sty' ],
    ['texlive/texmf-dist/tex/latex/latexconfig/epstopdf-sys.cfg', '/', 'epstopdf-sys.cfg'],
  ],

  begriff: [
    ['texlive/texmf-dist/tex/latex/begriff/begriff.sty', '/', 'begriff.sty']
  ],

};


window.TeXLive = function(pdftex) {

  this.compile = function(code, root, callback) {
    var packages = detectPackages(code).concat(['_basic_']);
    
    downloadPackages(pdftex, root, packages, function() {
      pdftex.compile(code).then(function() {
        pdftex.getFile('/', 'pdftex-input-file.pdf').then(function(pdf) {
          callback.apply(this, arguments);
        });
      });
    });

    return this;
  }

  var downloadFiles = function(pdftex, root, files, callback) {
    var pending = files.length;
    var cb = function() {
      pending--;
      if(pending === 0)
        callback();
    }

    for(var i in files) {
      var f = files[i];
      f[0] = root+f[0];
      pdftex.addUrl.apply(pdftex, f).then(cb);
    }
  }

  var downloadPackages = function(pdftex, root, packages, callback) {
    var files = [];
    for(var i in packages) {
      var p = packages[i];
      var files_for_package = supported_packages[p];
      for(var j in files_for_package) {
        files.push(files_for_package[j]);
      }
    }

    var unique_files = [];
    for(var i in files) {
      var found = false;
      for(var j in unique_files) {
        if(unique_files[j][0] === files[i][0] &&
          unique_files[j][1] === files[i][1] &&
          unique_files[j][2] === files[i][2]) {
          found = true;
          break;
        }
      }
      if(!found)
        unique_files.push(files[i]);
    }
    downloadFiles(pdftex, root, unique_files, callback);
  }

  return this;
}


