document.addEventListener("turbolinks:load", function() {
  document.querySelectorAll('form[data-remote=true]').forEach(function(element, index){
    if( element.querySelectorAll('input[type=submit][data-complete-with]').length === 0 ){
      return;
    }

    element.addEventListener("ajax:complete", function(e) {
      [data, status, xhr] = e.detail;

      e.stopImmediatePropagation();
      var submit = this.querySelector('input[type=submit]');
      submit.value = submit.getAttribute('data-complete-with');
    });
  });
})
