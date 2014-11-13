filled: ->
  $(document).on 'blur', 'form input, form textarea, form select', ->
    if $(this).val() is ''
      $(this).removeClass 'filled'
    else
      $(this).addClass 'filled'
