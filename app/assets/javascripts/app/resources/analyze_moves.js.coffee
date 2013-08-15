# Service Class for Board
@Analyze_Moves = class Analyze_Moves
  constructor: (board=null) ->
    if board != null
      @set_up_board(board)

  set_up_board: (board) ->
    @board = board
    @moves = @board.moves
    @grid = @board.grid
    @played_words = @board.played_words
    @center = @board.center
    @width = @board.grid.width

  analyze: (board) ->
    @set_up_board(board)
    return false unless @valid_moves()
    return false unless @connect_tiles()
    return false unless @additional_words()
    return @cells_to_word(@moves)

  var_setup: ->
    direction = @find_direction_axes(@moves)
    @axes = direction.axes
    @moves = direction.sort
    @first = (_.first @moves)[@axes]
    @last = ( _.last @moves)[@axes]

  # Connect with other words to make one word ================================ #

  connect_tiles: ->
    @var_setup()
    @connect_top_and_left()
    @connect_bottom_and_right()
    @connect_gaps_in_middle()

  #check from first move to top or left of board
  connect_top_and_left: ->
    if @first != 0
      @loop_cells_for_tile {inital:(@first - 1), end:0, axes:@axes}, (cell) =>
        return false unless cell.tile?
        @moves.unshift cell

  #check from last move to bottom or right
  connect_bottom_and_right: ->
    if @last != (@width-1)
      @loop_cells_for_tile {inital:(@last  + 1), end:(@width - 1), axes:@axes}, (cell) =>
        return false unless cell.tile?
        @moves.push cell

  #check for gaps in start to finish
  connect_gaps_in_middle: ->
    @loop_cells_for_tile {inital:@first, end:@last, axes:@axes}, (cell) =>
      unless @is_in_moves cell
        @moves = _.union(@moves, [cell])

  # Connect with other words to make additional words ======================== #

  #check adjacent direction for new formed words
  additional_words: ->
    @found_words = []
    @loop_cells_for_tile {inital:@first, end:@last, axes:@axes}, (@cell_outer) =>
      #create key for new word path
      @found_words[@cell_outer[@axes]] ?= []
      @found_words[@cell_outer[@axes]].push @cell_outer
      @additional_words_top_and_left()
      @additional_words_bottom_and_right()
      @additional_words_no_results_found_check()

  additional_words_top_and_left: ->
    inital = @cell_outer[@oposite_axes @axes]-1
    value = @cell_outer[@axes]
    @loop_cells_for_tile {inital:inital, end:0, axes: @oposite_axes(@axes), value:value}, (cell_left) =>
      return false unless cell_left.tile?
      @found_words[cell_left[@axes]] ?= []
      @found_words[cell_left[@axes]].unshift(cell_left)

  additional_words_bottom_and_right: ->
    inital = @cell_outer[@oposite_axes @axes]+1
    value = @cell_outer[@axes]
    @loop_cells_for_tile {inital:inital, end:(@width-1), axes: @oposite_axes(@axes), value:value}, (cell_right) =>
      return false unless cell_right.tile?
      @found_words[cell_right[@axes]] ?= []
      @found_words[cell_right[@axes]].push(cell_right)

  additional_words_no_results_found_check: ->
    if @found_words[@cell_outer[@axes]].length == 1
      delete @found_words[@cell_outer[@axes]]
    #check if picked up already played words
    else if @word_already_made(@cells_to_word @found_words[@cell_outer[@axes]])
      delete @found_words[@cell_outer[@axes]]
    return true #must return true to keep outer loop from breaking


  # Scrabble rule Validation ========================================================= #

  # TODO - to follow real scrabble rules
  # In Scrabble you can play one tile, but currently that messes up how direction is
  # is determined. So game rules are two tile per set of moves for now.
  valid_moves: ->
    unless @are_moves_more_than_one()
      return false
    return false unless @check_first_set_of_moves_to_be_center()
    return true

  valid_move: (move) ->
    return false if @cell_has_tile(move)
    return false unless @subsequent_moves_aligment(move)
    return true
  cell_has_tile: (move) ->
    cell = @grid.get_cell_by_key(move)
    if cell.tile? then true else false

  subsequent_moves_aligment: (move) ->
    if @moves.length > 0
      if @moves[0].x == move.x || @moves[0].y == move.y then true else false
    else
      return true

  check_first_set_of_moves_to_be_center: (move) ->
    # in first play there must be a tile on center
    if @first_word_of_game()
      for move in @moves
        return true if @cell_on_center(move)
      return false
    else
      return true

  first_word_of_game: ->
    if @played_words.length == 0 then true else false

  cell_on_center: (cell) ->
    if cell.x == @center.x && cell.y == @center.y then true else false

  word_already_made: (word) ->
    for word_in_played_words in @played_words
      if word_in_played_words.value == word.value then return true
    return false

  are_moves_more_than_one: ->
    if @moves.length <= 1
      return false
    else
      return true

  # Helper Methods =========================================================== #

  cells_to_word: (cells) ->
    direction = @find_direction_axes cells
    cells = direction.sort
    word = "";score = 0;cells_ = []
    for cell in cells
      word += cell.tile.value
      score += cell.tile.score
      cells_.push cell
    {value:word, score:score, cells:cells_}

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
      cell = @grid.get_cell_by_key _.extend(value, oposite_axes_value)
      break unless callback(cell)

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

  add_key_to_value: (value, key) ->
    object = {}
    object[key] = value
    return object

  is_in_moves: (cell) ->
    for move in @moves
      return true if move.x == cell.x && move.y == cell.y
    return false