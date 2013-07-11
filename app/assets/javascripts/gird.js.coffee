window.grid = (grid_size, append_to_elm)->
  width = Math.sqrt grid_size
  columns = rows = [1..width]
  grid = $('<div id="board"></div>')

  for row in rows
    div_row = $("<div class='row' id='#{row}'></div>")
    for column in columns
      div_row.append($("<div class=\"cell\" data-row=\"#{row}\" data-column=\"#{column}\"></div>"))
    grid.append(div_row)

  return $(append_to_elm).append grid

window.find_center = (grid_size) ->
  center = $('#board').find('.cell')[(grid_size - 1)/2]
  $(center).html($('<i class="icon-star"></i>'))

window.find_edges = (grid_size) ->
  width = Math.sqrt grid_size
  left_top = $('#board').find('.cell')[0]
  right_top  = $('#board').find('.cell')[width-1]
  left_bottom = $('#board').find('.cell')[(grid_size - 1) - (width-1)]
  right_bottom = $('#board').find('.cell')[grid_size - 1]
  $(left_top).addClass('left_top')
  $(right_top).addClass('right_top')
  $(left_bottom).addClass('left_bottom')
  $(right_bottom).addClass('right_bottom')

