$(document).ready(function($){
  GAMEDAY.notification_function = function() {
    var NOTIFICATION_MESSAGE_CLOSE_DELAY = 3000;

    return {
      setMessage: function(type, message) {
        var html = ''
  			$('#notifications .notification-bar-container > *').remove();
  			html += "<div class='notification-bar-bkg-message-" + type + "'>";
  			html += "<div class='notification-bar'>";
  			html += "<div class='notification-bar-contents'>";
  			html += "<div class='message message-" + type + "'>";
        html += "</div></div></div></div>";

        $('#notifications .notification-bar-container').append(html);
        $('.message-' + type).html(message);        
    	},
  		show: function() {
        $('#notifications').slideDown("slow", function() {
          setTimeout("$('#notifications').slideUp('slow');", NOTIFICATION_MESSAGE_CLOSE_DELAY);
        });
      }
    }
  }
  
  GAMEDAY.Notification = GAMEDAY.notification_function();
  
  var html = '';
  $('.notification-bar-container .message').each(function() {
    html += jQuery.trim($(this).html());
  });

  if (html != '') {
			GAMEDAY.Notification.show();
  }
});