Reportrello.Auth = (function() {
  function Auth() {
    $('.login-trello').click(function() {
      this.authorize();
    }.bind(this));
  };

  Auth.prototype.authorize = function() {
    var self = this;

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
  };

  Auth.prototype.getMe = function() {
    var token = localStorage.getItem('trello_token');
    var self = this;

    Trello.rest(
      'GET',
      'members/me',
      {
        fields: 'username,fullName',
        boards: 'all',
        token: token
      },
      function (object) {
        self.authenticate(object, token);
      },
      function (a) { alert("Failed authentication"); }
    );
  };

  Auth.prototype.authenticate = function(object, token) {
    this.saveBoards(object, token)
      .done(function(object) {
        location.href = '/authentication/?user[token]=' + token + '&user[username]=' + object.username + '&user[fullname]=' + object.fullName
      });
  };

  Auth.prototype.saveBoards = function(object, token) {
    var dfd = jQuery.Deferred();

    $.each(object.boards, function(i, board) {
      Trello.rest(
        'GET',
        'boards/' + board.id + '/lists',
        {
          card_fields: 'name',
          fields: 'name',
          token: token
        },
        function(cards) {
          console.log($.extend(board, { cards_attributes: cards }));
        }
      )
    });

    dfd.resolve(object);

    return dfd;
  }

  return Auth;

})();
