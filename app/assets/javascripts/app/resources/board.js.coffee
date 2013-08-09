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
    @center = @grid[(@width - 1)/2][(@width - 1)/2]
    @center.bonus = "star"
  move: (x,y, tile) ->
    cell = @get_cell(x, y)
    if @valid_move cell
      cell.tile = tile
      @moves.push cell
      return true
    else
      return false
  make_word: ->
    if @valid_play()
      word = ""
      score = 0
      cells = []
      all_moves = @connect_other_words_with_moves()
      for cell in all_moves
        word += cell.tile.value
        score += cell.tile.score
        cells.push cell
      word = {value:word, score:score, cells:cells}
      if Dictionary.word(word.value)
        @played_words.push word
        @total_score += score
        @reset_moves()
        return true
      else
        return false
    else
      return false
  is_y_word: ->
    if @moves[0].y == @moves[1].y
      return _.sortBy @moves, (cell) ->
        return cell.x
    return false
  is_x_word: ->
    if @moves[0].x == @moves[1].x
      return _.sortBy @moves, (cell) ->
        return cell.y
    return false
  connect_other_words_with_moves: ->
    y_word = @is_y_word()
    x_word = @is_x_word()
    if x_word
      word = x_word
      first = (_.first word).y + 1
      last = ( _.last word).y + 1
      x_value = word[0].x
      for y in [first..0] by 1
        cell = @grid[x_value][y]
        return word if cell.tile == undefined
        word.unshift cell
      for y in [last..(@width-1)] by 1
        cell = @grid[x_value][y]
        return word if cell.tile == undefined
        word.push cell
      return word
    else if y_word
      word = y_word
      first = (_.first word).x + 1
      last = ( _.last word).x + 1
      y_value = word[0].y
      for x in [first..0] by 1
        cell = @grid[x][y_value]
        return word if cell.tile == undefined
        word.unshift cell
      for x in [last..(@width-1)] by 1
        cell = @grid[x][y_value]
        return word if cell.tile == undefined
        word.push cell
      return word
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
  cell_has_no_tile: (cell) ->
      if cell.tile == undefined
        return true
      else
        return false
  is_first_move_of_turn: ->
    if @moves.length == 0
      return true
    else
      return false
  subsequent_moves: (cell) ->
    if @moves[0].x == cell.x || @moves[0].y == cell.y
      return true
    else
      return false
  is_first_word_of_game: ->
    if @played_words.length == 0
      return true
    else
      return false
  cell_aligned_is_with_center: (cell) ->
    if cell.x == @center.x || cell.y == @center
      return true
    else
      return false
  valid_move: (cell) ->
    return false unless @cell_has_no_tile(cell)
    unless @is_first_move_of_turn()
      return false unless @subsequent_moves(cell)
    return true

  valid_play: ->
    # in first play there must be a tile on center
    if @is_first_word_of_game()
      for cell in @moves
        return false unless @cell_aligned_is_with_center(cell)
    return true

  reset_moves: ->
    @moves = []
  empty_moves_from_board: ->
    tiles = []
    for cell in @moves
      tiles.push cell.tile
      cell.tile = undefined
    return tiles



