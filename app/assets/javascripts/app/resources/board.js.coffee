window.Board = class Board
  constructor: () ->
    @GRID_SIZE = 255
    @grid = []
    @build()
    @grid[0].tile = new Tile('a', 3)

  build: ->
    range = [1..@GRID_SIZE]
    for num in range
      @grid.push new Cell
    @find_center()
    @find_edges()
  find_center:  ->
    center = @grid[(@GRID_SIZE - 1)/2]
    center.bonus = "star"

  find_edges:  ->
    width = Math.floor(Math.sqrt @GRID_SIZE)
    left_top = @grid[0]
    right_top  = @grid[width-1]
    left_bottom = @grid[(@GRID_SIZE - 1) - (width-1)]
    right_bottom = @grid[@GRID_SIZE - 1]
    left_top.edge = 'left_top'
    right_top.edge = 'right_top'
    left_bottom.edge = 'left_bottom'
    right_bottom.edge = 'right_bottom'


