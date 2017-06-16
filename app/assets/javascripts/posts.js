// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(document).on('turbolinks:load', function(){
  // SimpleMDE in form

  var element = $("#post_text_md");

  if (element[0]) {
    var value = element.val();
    var simplemde = new SimpleMDE({
      element: element[0],
      initialValue: value,
      placeholder: "Type here the content...",
      spellChecker: false,
      status: false,
      previewRender: function(plainText, preview) {
          var converter = new MarkdownConverter();
          converter.to_html(plainText).then(function(response){
            preview.innerHTML = response;
          });
        return "Loading...";
      }
    });
  }

});

class MarkdownConverter {
  constructor() {
    this.endpoint = "/markdown";
  }

  to_html(mdText) {
    let endpoint = `${this.endpoint}/to_html`;
    return this._request('POST', endpoint, {markdown: {text_md: mdText}});
  }

  _request(method, url, params){
    return $.ajax({
      method: method,
      url: url,
      data: params,
      async: true
    });
  }
}


