window.detect_word = ->
  #event listener that checks if word is hor/ver
  #Case 1
  #left to end
  #how many cells are there?
  size = $('.cell').length # => 225
  width = Math.sqrt size
  # parse gird column at a time

  #Case 2
  # top to bottom
