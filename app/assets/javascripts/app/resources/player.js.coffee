@Player = class Player
  constructor: (@game, @name="You") ->
    @rack = new Rack
    @score=0
    @log()

  move: (x, y, value) ->
    tile = @rack.find_by_value value
    @game.move(new Move(x,y, tile, @name))

  move_by_word: (start_point, end_point, values) ->
    if start_point.x == end_point.x
      for y in [start_point.y..end_point.y]
        @move(end_point.x, y, values[y])
    else if start_point.y == end_point.y
      for x in [start_point.x..end_point.x]
        @move(x, end_point.y, values[y])
    @log()

  play_word: ->
    @game.play_word()
    @log()

  swap_tiles: (tiles) ->
    @game.swap_tiles(tiles)
    @log()

  log: ->
    console.log @name
    @rack.log()
    console.log "Total Score: " +  @score
