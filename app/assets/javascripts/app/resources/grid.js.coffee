@Grid = class Grid
  constructor: (grid_size) ->
    @GRID_SIZE = grid_size
    @width = (Math.floor Math.sqrt(@GRID_SIZE))
    @grid = []
    for index in [0..(@GRID_SIZE - 1)]
      x_y = @_x_y index
      @grid[index] = new Cell(x_y.x, x_y.y)

  get_cell: (x, y) ->
    @grid[@width * x + y]

  get_cell_by_key: (values) ->
    @get_cell(values.x, values.y)

  # Displays Grid in console
  log: ->
    row = ""
    grid = ""
    x_values = "   "
    for x in [0..@width - 1]
      unless x >= 10
        x_values +=  x + " "
      else
         x_values +=  x
    grid = x_values + "\n"
    for y in [0..@width - 1]
      for x in [0..@width - 1]
        cell = @get_cell(x, y)
        if cell.tile == undefined
          tile = "_ "
        else
          tile = cell.tile.value + " "
        if row == ""
          row = "#{y} "
          row = " " + row unless y >= 10
        row += tile
      grid += row + "\n"
      row = ""
    console.log grid

  # Private Methods ========================================================== #

  _x: (index) ->
    Math.floor (index % @width)

  _y: (index) ->
    Math.floor (index / @width)

  _x_y: (index) ->
    {x:@_x(index), y:@_y(index)}