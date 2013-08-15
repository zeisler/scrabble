@Tile = class Tile
  constructor: (value, score) ->
    @value = value
    @score = score
    @selected = true
  set_value: (value) ->
    @value = value
    return @
