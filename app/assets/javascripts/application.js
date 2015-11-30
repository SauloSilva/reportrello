//= require jquery

$(function() {
  $('.login-trello').click(function() {
    Trello.authorize({
      type: "redirect",
      name: "Reportrello",
      scope: {
        read: true,
        write: true
      }
    });
  });
})