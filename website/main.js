$(document).ready(function() {
  var button = $('button#compile');

  button.click(function(ev) {
    button.text('Downloading…');
    button.attr('disabled', 'disabled');
    button.addClass('disabled');

    var pdftex = new PDFTeX();
    window.pdftex = pdftex;

    var log = $('#log').text('');
    pdftex.on_stdout = function(txt) { log.append(txt+'\n'); }
    pdftex.on_stderr = function(txt) { log.append(txt+'\n'); }

    var code = $('#editor').val();

    var packages = ['_basic_'];
    
    downloadPackages(pdftex, packages, function() {
      button.text('Compiling…');
      pdftex.compile(code).then(function() {
        button.text('Opening PDF…');

        pdftex.getFile('/', 'pdftex-input-file.pdf').then(function(pdf) {
          button.text('Compile');
          button.removeAttr('disabled');
          button.removeClass('disabled');

         $('#buttons #open_pdf').remove();
         $('#buttons').append('<button id="open_pdf" class="btn">Open PDF</button>').click(function() { window.open('data:application/pdf;base64,'+window.btoa(pdf)); });
        });
      });
    });
  });

  var root = "../../";
  var supported_packages = {
    "_basic_": [
      [root+'texlive/latex.fmt', '/', 'latex.fmt'],
      [root+'test.tex', '/', 'test.tex'],
      [root+'texlive/texmf-dist/tex/latex/base/article.cls', '/', 'article.cls'],

      [root+'texlive/texmf-dist/source/latex/base/size10.clo', '/', 'size10.clo'],
      [root+'texlive/texmf-dist/fonts/tfm/public/cm/cmr17.tfm', '/', 'cmr17.tfm'],
      [root+'texlive/texmf-dist/fonts/tfm/public/cm/cmr12.tfm', '/', 'cmr12.tfm'],
      [root+'texlive/texmf-dist/fonts/tfm/public/cm/cmr10.tfm', '/', 'cmr10.tfm'],
      [root+'texlive/texmf-dist/fonts/tfm/public/cm/cmr8.tfm', '/', 'cmr8.tfm'],
      [root+'texlive/texmf-dist/fonts/tfm/public/cm/cmr6.tfm', '/', 'cmr6.tfm'],

      [root+'texlive/texmf-dist/fonts/tfm/public/cm/cmbx12.tfm', '/', 'cmbx12.tfm'],
      [root+'texlive/texmf-dist/fonts/tfm/public/cm/cmti10.tfm', '/', 'cmti10.tfm'],

      [root+'texlive/texmf-dist/fonts/tfm/public/cm/cmmi12.tfm', '/', 'cmmi12.tfm'],
      [root+'texlive/texmf-dist/fonts/tfm/public/cm/cmmi8.tfm', '/', 'cmmi8.tfm'],
      [root+'texlive/texmf-dist/fonts/tfm/public/cm/cmmi6.tfm', '/', 'cmmi6.tfm'],

      [root+'texlive/texmf-dist/fonts/tfm/public/cm/cmsy10.tfm', '/', 'cmsy10.tfm'],
      [root+'texlive/texmf-dist/fonts/tfm/public/cm/cmsy8.tfm', '/', 'cmsy8.tfm'],
      [root+'texlive/texmf-dist/fonts/tfm/public/cm/cmsy6.tfm', '/', 'cmsy6.tfm'],

      [root+'texlive/texmf-dist/fonts/type1/public/amsfonts/cm/cmsy10.pfb', '/', 'cmsy10.pfb'],
      [root+'texlive/texmf-dist/fonts/type1/public/amsfonts/cm/cmsy7.pfb', '/', 'cmsy7.pfb'],
      [root+'texlive/texmf-dist/fonts/type1/public/amsfonts/cm/cmti10.pfb', '/', 'cmti10.pfb'],

      [root+'texlive/texmf-dist/source/latex/base/pdftex.map', '/', 'pdftex.map'],

      [root+'texlive/texmf-dist/fonts/type1/public/amsfonts/cm/cmr17.pfb', '/', 'cmr17.pfb'],
      [root+'texlive/texmf-dist/fonts/type1/public/amsfonts/cm/cmr12.pfb', '/', 'cmr12.pfb'],
      [root+'texlive/texmf-dist/fonts/type1/public/amsfonts/cm/cmr10.pfb', '/', 'cmr10.pfb'],
      [root+'texlive/texmf-dist/fonts/type1/public/amsfonts/cm/cmr8.pfb', '/', 'cmr8.pfb'],
      [root+'texlive/texmf-dist/fonts/type1/public/amsfonts/cm/cmr7.pfb', '/', 'cmr7.pfb'],
      [root+'texlive/texmf-dist/fonts/type1/public/amsfonts/cm/cmr6.pfb', '/', 'cmr6.pfb'],
      [root+'texlive/texmf-dist/fonts/type1/public/amsfonts/cm/cmbx12.pfb', '/', 'cmbx12.pfb'],
      [root+'texlive/texmf-dist/fonts/type1/public/amsfonts/cm/cmex10.pfb', '/', 'cmex10.pfb'],
      [root+'texlive/texmf-dist/fonts/type1/public/amsfonts/cm/cmmi10.pfb', '/', 'cmmi10.pfb'],
      [root+'texlive/texmf-dist/fonts/type1/public/amsfonts/cm/cmmi7.pfb', '/', 'cmmi7.pfb'],

    ]
  };


  var downloadPackages = function(pdftex, packages, callback) {
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
    downloadFiles(pdftex, unique_files, callback);
  }


  var downloadFiles = function(pdftex, files, callback) {
    var pending = files.length;
    var cb = function() {
      pending--;
      if(pending === 0)
        callback();
    }

    for(var i in files) {
      pdftex.addUrl.apply(pdftex, files[i]).then(cb);
    }
  }
});

