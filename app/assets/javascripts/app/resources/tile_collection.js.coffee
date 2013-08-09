window.Tile_Collection = class Tile_Collection
  constructor: ()->
    @collection = []
    @id = 0
  on_change: (obj, msg) ->
    return false
  all: ->
    return @collection
  all_by_value: ->
    tiles = ""
    for tile in @collection
      tiles += (tile.value + ", ")
    return tiles
  remove_at: (index) ->
    tile = @collection.splice(index, 1)
    unless tile == -1
      return tile[0]
    else
      return false
  add: (tile) ->
    if tile == undefined
      return false
    else
      @collection.push tile
      @id += 1
  add_in_mass: (array_of_tiles) ->
    for tile in array_of_tiles
      @add(tile)
  find_selected: ->
    tiles = []
    for tile in @collection
      if tile.selected == true
        tiles.push tile
    return tiles
  shuffle: ->
    @collection = @shuffle_logic(@collection)
    for tile in @collection
      @on_change(tile, "shuffle")
  shuffle_logic: (a) ->
    i = a.length
    while --i > 0
        j = ~~(Math.random() * (i + 1))
        t = a[j]
        a[j] = a[i]
        a[i] = t
    a
  quantity: ->
    @collection.length
  remove_by_letter: (letter) ->
    @remove_at @find_by_letter(letter)
  #finds letter and returns index
  find_by_letter: (letter) ->

    for tile in @collection
      if tile.value == letter
        return _i
    return null
  at: (index)->
    return @collection[index]
