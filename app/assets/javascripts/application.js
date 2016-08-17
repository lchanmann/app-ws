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

// window.App = {
//   currentQueries: function() {
//     if (document.querySelector('.queries')) {
//       fetch(window.location.href, {
//         headers: {
//           'X-Requested-With': 'XMLHttpRequest',
//           'Accept': 'application/javascript',
//           'Content-Type': 'application/javascript'
//         }
//       }).then(function(response) {
//         if (response.ok)
//           return response.text();
//       }).then(function(text) {
//         eval(text);
//       });
//     }
//   }
// }
// 
// updateCurrentQueries = function() {
//   setInterval(window.App.currentQueries, 3000);
// }
// 
// // onload (copy from -> https://github.com/spree/spree/pull/6670)
// if (window.addEventListener)
//   window.addEventListener("load", updateCurrentQueries, "false");
// else if (window.attachEvent)
//   window.attachEvent("onload", updateCurrentQueries);
// else  window.onload = updateCurrentQueries;
// 
