// once text has been filled add another class to it (so it's possible to style it differently)
filled: function()
{
  $(document).on('blur', 'form input, form textarea, form select', function()
  {
    if($(this).val() == '') $(this).removeClass('filled');
    else $(this).addClass('filled');
  });
}
