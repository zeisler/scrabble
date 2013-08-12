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
      word = "";score = 0;cells = []
      @connect_other_words_with_moves()
      @adjacent_words()
      for cell in @moves
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
  sort_by_axes: (axes, vector) ->
    return _.sortBy vector, (cell) =>
      return cell[axes]
  find_direction_axes: ->
    # if axes is consistent it's moving in the other direction
    x_sort = @sort_by_axes("x", @moves)
    if x_sort[1].x > x_sort[0].x
      return {axes:"x", sort:x_sort}
    y_sort = @sort_by_axes("y", @moves)
    if y_sort[1].y > y_sort[0].y
      return {axes:"y", sort: y_sort}
  oposite_axes: (axes) ->
    if axes is "x" then return "y"
    if axes is "y" then return "x"

  connect_other_words_with_moves:  ->
    direction = @find_direction_axes()
    axes = direction.axes
    @moves = direction.sort
    first = (_.first @moves)[axes]
    last = ( _.last @moves)[axes]
    #check in both direction for connecting words
    #check from first move to top or left of board
    if first != 0
      @loop_cells_for_tile {inital:(first - 1), end:0, axes:axes}, (cell) =>
        return false unless cell.tile?
        @moves.unshift cell
    #check from last move to bottom or right
    if last != (@width-1)
      @loop_cells_for_tile {inital:(last  + 1), end:(@width-1), axes:axes}, (cell) =>
        return false unless cell.tile?
        @moves.push cell
    #check for gaps in start to finish, possible connections with other words
    @loop_cells_for_tile {inital:first, end:last, axes:axes}, (cell) =>
      @moves = _.union(@moves, [cell])
    #check adjacent direction for new formed words
    @additional_words = []
    @loop_cells_for_tile {inital:first, end:last, axes:axes}, (cell) =>
      @additional_words[cell[@oposite_axes axes]] ?= []
      @additional_words[cell[@oposite_axes axes]].push cell
      #check left / top
      @loop_cells_for_tile {inital:cell[@oposite_axes axes]-1, 0, axes:axes}, (cell) =>
        return false unless cell.tile?
        @additional_words[cell[@oposite_axes axes]] ?= []
        @additional_words[cell[@oposite_axes axes]].unshift(cell)
      #check right / bottom
      @loop_cells_for_tile {inital:cell[@oposite_axes axes]+1, end:(@width-1), axes:axes}, (cell) =>
        return false unless cell.tile?
        @additional_words[cell[@oposite_axes axes]] ?= []
        @additional_words[cell[@oposite_axes(axes)]].push(cell)
    console.log @additional_words
    #sort moves in valid direction
    @moves = @sort_by_axes axes, @moves
  loop_cells_for_tile: (args, callback) ->
    oposite_axes = @oposite_axes args.axes
    oposite_axes_value = {}
    oposite_axes_value[oposite_axes] = @moves[0][oposite_axes]
    for value in [args.inital..args.end]
      value = @add_key_to_value(value, args.axes)
      cell = @grid_key _.extend(value, oposite_axes_value)
      break unless callback(cell)
  adjacent_words: (moves) ->
    moves
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
  cell_has_tile: (cell) ->
    if cell.tile? then true else false
  first_move_of_turn: ->
    if @moves.length == 0 then true else false
  subsequent_moves: (cell) ->
    if @moves[0].x == cell.x || @moves[0].y == cell.y then true else false
  first_word_of_game: ->
    if @played_words.length == 0 then true else false
  cell_on_center: (cell) ->
    if cell.x == @center.x && cell.y == @center.y then true else false
  valid_move: (cell) ->
    return false if @cell_has_tile(cell)
    unless @first_move_of_turn()
      return false unless @subsequent_moves(cell)
    return true
  valid_play: ->
    # in first play there must be a tile on center
    if @first_word_of_game()
      for cell in @moves
        return true if @cell_on_center(cell)
      return false
    return true
  reset_moves: ->
    @moves = []
  retrack_moves_from_board: ->
    tiles = []
    for cell in @moves
      tiles.push cell.tile
      cell.tile = undefined
    @reset_moves()
    return tiles
  add_key_to_value: (value, key) ->
    object = {}
    object[key] = value
    return object
