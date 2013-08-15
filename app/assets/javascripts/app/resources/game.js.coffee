@Game = class Game
  constructor: ->
    @bag = new Bag

    @board = new Board
    @log_game()

  add_player: (@player = new Player(this)) ->
    @fill_rack()

  fill_rack: ->
    returned_tiles = @bag.take_up_to(@player.rack.quanity_until_full())
    @player.rack.add(returned_tiles)

  swap_by_value: (values) ->
    for value in values
      tile = @player.rack.remove_by_value value
      @bag.add(tile)
    @fill_rack()
    rack.log()

  move: (move) ->
    if @board.move(move)
      @player.score = @score_tiles(tiles)
      @log_game()
    @player.get_next_move()

  move_by_word: (start_point, direction, tiles, name) ->
    if @board.move_by_word(start_point, direction, tiles, name)
      @log_game()


  score_tiles: (tiles) ->
    score = 0
    for tile in tiles
      score += tile.score
    return score

  get_next_move: ->
    @player.get_next_move()

  play_word: ->
    score = @board.make_word()
    if score
      @fill_rack()
      @player.score += score
      @log_game()
      @player.get_next_move()
      return true
    else
      @log_game()
      return false

  log_game: ->
    @board.grid.log()

