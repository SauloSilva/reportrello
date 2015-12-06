//= require jquery
//= require bootstrap-material-design
//= require bootstrap-material-design/scripts/ripples

$(function() {
  $.material.init()

  $('.login-trello').click(function() {
    Reportrello.authorize();
  });

  Reportrello = {
    authorize: function() {
      var self = this

      Trello.authorize({
        type: 'popup',
        name: 'Reportrello',
        fragment: 'postmessage',
        scope: {
          read: true,
          write: true
        },
        expiration: 'never',
        success: function() {
          self.getMe();
        },
        error: function() {
          alert("Failed authentication");
        }
      });
    },

    getMe: function() {
      var token = localStorage.getItem('trello_token');

      Trello.rest(
        'GET',
        'members/me',
        {
          fields: 'username,fullName,avatar',
          token: token
        },
        function (object) {
          location.href = '/authentication/?user[token]=' + token + '&user[username]=' + object.username + '&user[fullname]=' + object.fullName
        },
        function (a) { alert("Failed authentication"); }
      );
    },

    newReport: function() {

    }
  }
})