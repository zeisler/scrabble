@Board = class Board
  constructor: () ->
    @build()
    @moves = []
    @played_words = []
    @total_score = 0
    @analyze = new Analyze_Moves()

  build: ->
    @grid = new Grid 225
    @find_center()
    @find_edges()

  move: (move) ->
    @analyze.set_up_board(this)
    if @analyze.valid_move(move)
      @moves.push move
      @put_move_on_grid(move)
    else
      return false

  move_by_word: (start_point, direction, tiles, name) ->
    letter_index = 0
    oposite_axes = @analyze.oposite_axes(direction)
    start = start_point[oposite_axes]
    for index in [start..(start + (tiles.length - 1))]
      move = {}
      move[oposite_axes] = index
      move[direction] = start_point[direction]
      @move(new Move move.x, move.y, tiles[letter_index], name)

      letter_index += 1


  make_word: ->
    word = @analyze.analyze(this)
    if word
      if Dictionary.is_word(word.value)
        @played_words.push @moves
        @reset_moves()
        return word.score

  score_word: ->
    score = 0
    for move in @moves
      score += move.tile.score
    return score
  put_tiles_on_grid: ->
    for move in @moves
      @put_move_on_grid move

  put_move_on_grid: (move) ->
     (@grid.get_cell_by_key move).tile = move.tile

  word_already_made: (word) ->
    for word_in_played_words in @played_words
      if word_in_played_words.value == word.value then return true
    return false

  create_words_from_all_moves: () ->
    @additional_words.push @moves
    @moves = @additional_words

  reset_moves: ->
    @moves = []

  retract_moves_from_board: ->
    tiles = []
    for cell in @moves
      unless cell == undefined
        tiles.push cell.tile
        cell.tile = undefined
    @reset_moves()
    return tiles

  # Bonuses and Decorators =================================================== #

  find_edges:  ->
    width = @grid.width - 1
    left_top = @grid.get_cell 0, 0
    right_top  = @grid.get_cell width, 0
    left_bottom = @grid.get_cell 0, width
    right_bottom = @grid.get_cell width, width
    left_top.edge = 'left_top'
    right_top.edge = 'right_top'
    left_bottom.edge = 'left_bottom'
    right_bottom.edge = 'right_bottom'

  find_center:  ->
    @center = @grid.get_cell((@grid.width - 1)/2,(@grid.width - 1)/2)
    @center.bonus = "star"