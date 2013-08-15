@Player = class Player
  constructor: (@game, @name="You") ->
    @rack = new Rack
    @score=0
    @log()

  move: (x, y, value) ->
    tile = @rack.remove_by_value value
    if tile?
      @game.move(new Move(x, y, tile, @name))
    @log()
  move_by_word: (start_point, direction, values) ->
    tiles = []
    for value in values
      tiles.push @rack.remove_by_value value
    @game.move_by_word(start_point, direction, tiles, @name)
    @log()


  play_word: ->
    @game.play_word()
    @log()

  swap_tiles: (tiles) ->
    @game.swap_tiles(tiles)
    @log()

  get_next_move: ->
   letter = prompt "Enter letter from rack \n" + @rack.all_by_value()
   loc = prompt "enter x, y"
   loc = loc.split(",")
   x = parseInt loc[0]; y = parseInt loc[1]
   @move(x, y,letter)

  log: ->
    console.log @name
    @rack.log()
    console.log "Total Score: " +  @score
