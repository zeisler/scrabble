//= require scrabble/tile
window.Tile_Collection = class Tile_Collection
  constructor: ()->
    @collection = new Object()
    @id = 0
  on_change: ->
    return false
  all: (index)->
    return @collection
  remove_at: (index) ->
    tile = @collection.splice(index, 1)
    unless tile == -1
      @on_change(tile, "remove_at")
    return tile
  remove_by_id: (id) ->
    index = @find_index(id)
    @remove_at index
  add: (letter,score) ->
      @collection[@id] = new Tile(letter, score)
      @id += 1
      @on_change(this.collection[this.id], "add")
  shuffle: ->
    collection = shuffle @collection.first()
    @collection = []
    @collection.push collection
  quantity: ->
    @collection.length
  remove: (tiles)->
    tiles = to_array tiles
    tiles_to_be_returned = []
    for tile in tiles
      index = @find_index(tile)
      @remove_at index
      tiles_to_be_returned.push(tile)
    return tiles_to_be_returned

  #use tile obj or id of obj to get index in array
  find_index: (tile) ->
    unless typeof tile == 'number'
      id = tile.id
    else
      id = tile
    index = 0
    for tile in @collection
      if tile.id = id
        return index
      index += 1
