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
      status: false
      // previewRender: function(plainText, preview) {
      //   // Async method
      //   setTimeout(function(){
      //     preview.innerHTML = "<h1>Testing assync parser</h1>";
      //   }, 1000);
      //   return "Loading...";
      // }
    });
  }

});


