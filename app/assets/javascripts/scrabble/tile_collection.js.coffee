//= require scrabble/tile
window.Tile_Collection = class Tile_Collection
  constructor: ()->
    @collection = []
    @id = 0
  on_change: (obj, msg) ->
    return false
  all: (index)->
    return @collection
  remove_at: (index) ->
    tile = @collection.splice(index, 1)
    unless tile == -1
      @on_change(tile, "remove_at")
    # [0] removes the array wrapper
    return tile[0]
  add: (letter,score) ->
      @collection.push new Tile(letter, score)
      @id += 1
      @on_change(this.collection[this.id], "add")
  shuffle: ->
    collection = shuffle @collection
    @collection = []
    @collection.push collection
  quantity: ->
    @collection.length
  #finds letter and returns index
  find_by_letter: (letter) ->
    for tile in @collection
      if tile.value == letter
        return tile
    return null
  at: (index)->
    return @collection[index]
