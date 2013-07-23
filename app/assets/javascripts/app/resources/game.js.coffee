window.Game = class Game
  constructor: ()->
    @bag = new Bag
    @rack = new Rack
    @fill_rack()
    @board = new Board
    @played_words = []

  fill_rack: ->
    number_to_fill = @rack.quanity_until_full()
    returned_tiles = @bag.take_up_to(number_to_fill)
    @rack.add_in_mass (returned_tiles)
  validate_word: (tiles)->
    new Word(tiles, @word_is_valid)
  word_is_valid: (word) =>
    @played_words.push word
  swap_tiles: (tiles) ->
    for tile in tiles
      unless tile == undefined
        @rack.remove_by_letter tile.value
        @bag.add(tile)
    @fill_rack()

