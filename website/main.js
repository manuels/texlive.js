var root = "../../";

$(document).ready(function() {
  var button = $('button#compile');

  button.click(function(ev) {
    button.text('Downloading and compiling…');
    button.attr('disabled', 'disabled');
    button.addClass('disabled');

    var pdftex = new PDFTeX('./');
    window.pdftex = pdftex;

    var log = $('#log').text('');
    pdftex.on_stdout = function(txt) { log.append(txt+'\n'); }
    pdftex.on_stderr = function(txt) { log.append(txt+'\n'); }

    var code = $('#editor').val();

    
    downloadFiles(pdftex, document_files, function() {
      var texlive = new TeXLive(pdftex);

      texlive.compile(code, root, function(pdf) {
        button.text('Compile');
        button.removeAttr('disabled');
        button.removeClass('disabled');
 
        $('#buttons #open_pdf').remove();
        $('#buttons').append('<button id="open_pdf" class="btn">Open PDF</button>').find('#open_pdf').click(function() { window.open('data:application/pdf;base64,'+window.btoa(pdf)); });
      });
    });
  });

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

  var document_files = [
      [root+'test.jpg', '/', 'test.jpg']
  ];
});

