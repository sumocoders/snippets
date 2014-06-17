## This build a navigation list for a sidebar so it can scroll to the correct section of the page

# check if we want to build a navigation-list
if $('[data-build-navigation]').length > 0

  $wrap = $('[data-build-navigation]')

  # The title we want to scroll to
  $section = $('h3')

  # start of the navigation list
  $navigation = '<ul>'

  # used for unique links
  i = 0

  #check for each section
  $section.each ->
    $this = $(this)

    # construct and set the id on the title
    id = 'link' + i
    $this.attr('id', id)

    # get the title and add it to the navigation
    link = '#link' + i
    title = $this.text()
    $navigation += '<li><a href="' + link + '">' + title + '</a></li>'

    i++

  # closing tag of the navigation list
  $navigation += '</ul>'

  # set navigation in the selected div/section
  $wrap.append($navigation)
