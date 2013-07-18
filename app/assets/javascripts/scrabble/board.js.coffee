window.Board = class Board
  constructor: (grid_size=225,html_id="game-board") ->
    @grid_size = grid_size
    @html_id = html_id
    @id = "##{@html_id}"
    @grid()
    @find_center()
    @find_edges()
    @ui_drag_drop()

  ui_drag_drop: ->
    $(".cell").droppable
    accept: "li.tile"
    hoverClass: "cell-hover"
    drop: (event, ui)->
      tile = ui.helper
      if word_direction(this, tile)
        move_tile_to_cell(this, tile)
        $(tile.helper).addClass('tile-active')
      else
        move_tile_to_rack(tile)
  grid: ->
    width = Math.sqrt @grid_size
    columns = rows = [1..width]
    grid = $("<div id='#{@html_id}'></div>")

    for row in rows
      div_row = $("<div class='row' id='#{row}'></div>")
      for column in columns
        div_row.append($("<div class=\"cell\" data-row=\"#{row}\" data-column=\"#{column}\"></div>"))
      grid.append(div_row)

    return $(@id).append grid

  find_center: (@grid_size) ->
    center = $(@id).find('.cell')[(@grid_size - 1)/2]
    $(center).html($('<i class="icon-star"></i>'))

  find_edges: (@grid_size) ->
    width = Math.sqrt @grid_size
    left_top = $(@id).find('.cell')[0]
    right_top  = $(@id).find('.cell')[width-1]
    left_bottom = $(@id).find('.cell')[(@grid_size - 1) - (width-1)]
    right_bottom = $(@id).find('.cell')[@grid_size - 1]
    $(left_top).addClass('left_top')
    $(right_top).addClass('right_top')
    $(left_bottom).addClass('left_bottom')
    $(right_bottom).addClass('right_bottom')


