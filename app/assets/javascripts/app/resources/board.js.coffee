@Board = class Board
  constructor: () ->
    @GRID_SIZE = 255
    @width = Math.floor Math.sqrt(@GRID_SIZE - 1)
    @grid = []
    @build()
    @moves = []
    @played_words = []
    @total_score = 0
  build: ->
    @grid = Grid(@GRID_SIZE)
    @find_center()
    @find_edges()
  get_cell: (x,y) ->
    @grid[x][y]
  find_center:  ->
    center = @grid[(@width - 1)/2][(@width - 1)/2]
    center.bonus = "star"
  move: (x,y, tile) ->
    cell = @get_cell(x, y)
    if @valid_moves cell
      cell.tile = tile
      @moves.push cell
      return true
    else
      return false
  make_word: ->
    if @moves.length > 1
      word = ""
      score = 0
      cells = []
      for cell in @moves
        word += cell.tile.value
        score += cell.tile.score
        cells.push cell
      word = {value:word, score:score, cells:cells}
      if Dictionary.word(word.value)
        @played_words.push word
        @total_score += score
        return true
      else
        return false
    else
      return false
  find_edges:  ->
    width = @width - 1
    left_top = @grid[0][0]
    right_top  = @grid[width][0]
    left_bottom = @grid[0][width]
    right_bottom = @grid[width][width]
    left_top.edge = 'left_top'
    right_top.edge = 'right_top'
    left_bottom.edge = 'left_bottom'
    right_bottom.edge = 'right_bottom'
  valid_moves: (cell)->
    if @moves.length == 0
      return true
    else if @moves.length > 0
      if @moves[0].x == cell.x || @moves[0].y == cell.y
        return true
      else
        return false



