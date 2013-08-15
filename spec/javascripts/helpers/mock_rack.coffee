@Mock_Rack = class Mock_Rack extends Rack
  constructor: (letters) ->
    super
    for letter in letters
      @add new Tile(letter, 1)
