//= require lib/array
//= require scrabble/tile_collection
//= require scrabble/bag
//= require scrabble/rack
//= require scrabble/board
$().ready ->
  window.Game = class Game
    constructor: ()->
      @bag = new Bag
      @bag.fill()
      @rack = new Rack
      @fill_rack()
      @rack.display_rack()
      @board = new Board
      @set_buttons()

    fill_rack: ->
      number_to_fill = @rack.quanity_until_full()
      returned_tiles = @bag.take_up_to(number_to_fill)
      @rack.add_in_mass (returned_tiles)

    swap_tiles: (tiles) ->
      for tile in tiles
        unless tile == undefined
          @rack.remove_by_letter tile.value
          @bag.add(tile.value, tile.score)
      @fill_rack()
    set_buttons: ->
      $('#new_rack').on 'click', =>
        @swap_tiles(@rack.all())
  window.game = new Game();
