//= require jquery
//= require turbolinks

$(function() {
  window.App = {
    updateCurrentQueries: function() {
      if ($('.queries').length > 0) {
        $.ajax({
          url: window.location.href,
          cache :true,
          dataType: 'script'});
      }
    }
  }

  // update current queries every 3 seconds
  setInterval(window.App.updateCurrentQueries, 3000);
});
