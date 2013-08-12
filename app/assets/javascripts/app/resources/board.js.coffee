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
  cells_to_word: (cells) ->
    direction = @find_direction_axes cells
    cells = direction.sort
    word = "";score = 0;cells_ = []
    for cell in cells
      word += cell.tile.value
      score += cell.tile.score
      cells_.push cell
    {value:word, score:score, cells:cells_}
  make_word: ->
    if @valid_play()
      @connect_other_words_with_moves()
      @create_words_from_all_moves()
      @moves.forEach (element, index, array) =>
        word = @cells_to_word element
        if Dictionary.word(word.value)
          @played_words.push word
          @total_score += word.score
          @reset_moves()
          return true
        else
          # @retrack_moves_from_board()
          return false
    else
      # @retrack_moves_from_board()
      return false
    return true
  sort_by_axes: (axes, vector) ->
    return _.sortBy vector, (cell) =>
      return cell[axes]
  find_direction_axes: (cells) ->
    # if axes is consistent it's moving in the other direction
    x_sort = @sort_by_axes("x", cells)
    if x_sort[1].x > x_sort[0].x
      return {axes:"x", sort:x_sort}
    y_sort = @sort_by_axes("y", cells)
    if y_sort[1].y > y_sort[0].y
      return {axes:"y", sort: y_sort}
  oposite_axes: (axes) ->
    if axes is "x" then return "y"
    if axes is "y" then return "x"

  connect_other_words_with_moves:  ->
    direction = @find_direction_axes(@moves)
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
    @loop_cells_for_tile {inital:first, end:last, axes:axes}, (cell_outer) =>
      #create key for new word path
      @additional_words[cell_outer[axes]] ?= []
      @additional_words[cell_outer[axes]].push cell_outer

      #check left / top
      inital = cell_outer[@oposite_axes axes]-1
      value = cell_outer[axes]
      @loop_cells_for_tile {inital:inital, end:0, axes: @oposite_axes(axes), value:value}, (cell_left) =>
        return false unless cell_left.tile?
        @additional_words[cell_left[axes]] ?= []
        @additional_words[cell_left[axes]].unshift(cell_left)

      #check right / bottom
      inital = cell_outer[@oposite_axes axes]+1
      @loop_cells_for_tile {inital:inital, end:(@width-1), axes: @oposite_axes(axes), value:value}, (cell_right) =>
        return false unless cell_right.tile?
        @additional_words[cell_right[axes]] ?= []
        @additional_words[cell_right[axes]].push(cell_right)

      #found no results
      if @additional_words[cell_outer[axes]].length == 1
        delete @additional_words[cell_outer[axes]]
      #check if picked up already played words
      else if @word_already_made(@cells_to_word @additional_words[cell_outer[axes]])
        delete @additional_words[cell_outer[axes]]
      return true #must return true to keep outer loop from breaking
    console.log @additional_words

  loop_cells_for_tile: (args, callback) ->
    oposite_axes = @oposite_axes args.axes
    oposite_axes_value = {}
    if args.value == undefined
      value = @moves[0][oposite_axes]
      oposite_axes_value[oposite_axes] = value
    else
      oposite_axes_value[oposite_axes] = args.value
    for value in [args.inital..args.end]
      value = @add_key_to_value(value, args.axes)
      cell = @grid_key _.extend(value, oposite_axes_value)
      break unless callback(cell)
  word_already_made: (word) ->
    for word_in_played_words in @played_words
      if word_in_played_words.value == word.value then return true
    return false
  create_words_from_all_moves: () ->
    @additional_words.push @moves
    @moves = @additional_words
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
      unless cell == undefined
        tiles.push cell.tile
        cell.tile = undefined
    @reset_moves()
    return tiles
  add_key_to_value: (value, key) ->
    object = {}
    object[key] = value
    return object
