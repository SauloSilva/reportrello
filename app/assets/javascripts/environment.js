Reportrello.Environment = (function() {
  function Environment() {
    this.$environmentField = $('.environment-field');
    this.$environmentsField = $('.environments-field');
    this.enviromentFieldsHTML = this.$environmentField[0].outerHTML;

    this.addHandler();
    this.deleleHandler();
  };

  Environment.prototype.addHandler = function() {
    var count = 1;

    $('.add-environment').click(function(e) {
      e.preventDefault();

      if (this.$environmentField.is("*")) {
        html = this.$environmentField[0].outerHTML.replace(/\[0\]/g,  '[' + count + ']');
        this.$environmentsField.append(html)
      } else {
        this.$environmentsField.append(enviromentFieldsHTML)
      }

      count += 1;
    }.bind(this));
  };

  Environment.prototype.deleleHandler = function() {
    this.$environmentsField.on('click', '.delete-environment', function() {
      $(this).parent().remove();
    });
  };

  return Environment;
})();