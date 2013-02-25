define [
  'spinner'
  ], (Spinner) ->
    $ = jQuery

    $.fn.buttonSpinner = (options) ->
      settings =
        debug: true
        spin: true
        color: '#000'
        lines: 12
        width: 2
        length: 2
        radius: 3
        top: 'auto'
        left: 'auto'

      settings = $.extend settings, options
        
      return @each () ->
        if settings.spin
          $(@).attr('disabled','disabled')
          @spinner = new Spinner(settings)
          @spinner.spin(@)
        else
          $(@).removeAttr("disabled")
          @spinner.stop() if @spinner
