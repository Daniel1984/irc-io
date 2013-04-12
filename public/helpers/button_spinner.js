define(['spinner'], function(Spinner) {
  var $;

  $ = jQuery;
  return $.fn.buttonSpinner = function(options) {
    var settings;

    settings = {
      debug: true,
      spin: true,
      color: '#000',
      lines: 12,
      width: 2,
      length: 2,
      radius: 3,
      top: 'auto',
      left: 'auto'
    };
    settings = $.extend(settings, options);
    return this.each(function() {
      if (settings.spin) {
        $(this).attr('disabled', 'disabled');
        this.spinner = new Spinner(settings);
        return this.spinner.spin(this);
      } else {
        $(this).removeAttr("disabled");
        if (this.spinner) {
          return this.spinner.stop();
        }
      }
    });
  };
});
