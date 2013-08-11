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
  grid_key: (axes) ->
    @grid[axes.x][axes.y]
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
      moves = @connect_other_words_with_moves()
      # moves = @check_for_words_new_adjacent_word(moves)
      for cell in moves
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
  sort_by_axes: (axes, vector) -> # takes in an axes if it doesn't change
    return _.sortBy vector, (cell) =>
      return cell[axes]
  find_direction_axes: ->
    # if axes is consistent it's moving in the other direction
    x_sort = @sort_by_axes("x", @moves)
    if x_sort[1].x > x_sort[0].x
      return {axes:"x", sort:x_sort}
    y_sort = @sort_by_axes("y", @moves)
    if y_sort[1].y > y_sort[0].y
      return {axes:"y", sort:y_sort}
  oposite_axes: (axes) ->
    if axes is "x" then return "y"
    if axes is "y" then return "x"

  connect_other_words_with_moves:  ->
    direction = @find_direction_axes()
    axes = direction.axes
    moves = direction.sort
    first = (_.first moves)[axes]
    last = ( _.last moves)[axes]
    oposite_axes = @oposite_axes axes
    oposite_axes_value = {}
    oposite_axes_value[oposite_axes] = moves[0][oposite_axes]
    #check out in both direction for connecting words
    if first != 0
      for value in [(first - 1)..0]
        value = @add_key_to_value(value, axes)
        cell = @grid_key _.extend(value, oposite_axes_value)
        if cell.tile == undefined
          break
        else
          moves.unshift cell
    if last != (@width-1)
      for value in [(last  + 1)..(@width-1)]
        value = @add_key_to_value(value, axes)
        cell = @grid_key _.extend(value, oposite_axes_value)
        if cell.tile == undefined
          break
        else
          moves.push cell
    #check for gaps start to finish, for connections in middle
    for value in [first..last]
      value = @add_key_to_value(value, axes)
      cell = @grid_key _.extend(value, oposite_axes_value)
      moves = _.union(moves, [cell])
    return @sort_by_axes axes, moves
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
  cell_is_on_center: (cell) ->
    if cell.x == @center.x && cell.y == @center.y
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
        return true if @cell_is_on_center(cell)
      return false
    return true

  reset_moves: ->
    @moves = []
  empty_moves_from_board: ->
    tiles = []
    for cell in @moves
      tiles.push cell.tile
      cell.tile = undefined
    return tiles
  add_key_to_value: (value, key) ->
    object = {}
    object[key] = value
    return object



