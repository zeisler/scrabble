@Tile_Collection = class Tile_Collection
  constructor: ->
    @collection = []

  # Returns an array of all tiles
  all: ->
    return @collection

  add: (tile) ->
    if _.isArray tile
      @_add_in_mass tile
    else if (tile instanceof Tile)
      @collection.push tile
      @id += 1
    else
      return false

  shuffle: ->
    @collection = @_shuffle_logic(@collection)

  quantity: ->
    @collection.length

  remove_by_value: (value) ->
    @_remove_at @_find_index_by_value(value)

  # Finds Blank first blank tile
  blank: ->
    for tile in @collection
      return tile if tile.value == "_"
    return false

  find_by_value: (value) ->
    @_at @_find_index_by_value(value)


  # Will return an amount of tiles but not more than what is in the bag
  take_up_to: (tiles_to_get)->
    if tiles_to_get > @quantity()
      tiles_to_get = @quantity()
    if tiles_to_get == 0
      return false
    tiles_to_return = []
    for tile in [1..tiles_to_get]
      random_index = @_getRandomInt(0, ((@quantity()) - 1))
      tiles_to_return.push @_remove_at(random_index)
    return tiles_to_return

  # Private Methods ========================================================== #

  #finds letter and returns index
   _find_index_by_value: (value) ->
    for tile in @collection
      if tile.value == value
        return _i
    return null

  _add_in_mass: (array_of_tiles) ->
    for tile in array_of_tiles
      @add(tile)

  _at: (index) ->
    return @collection[index]

  _remove_at: (index) ->
    tile = @collection.splice(index, 1)
    unless tile == -1
      return tile[0]
    else
      return false

  _shuffle_logic: (a) ->
    i = a.length
    while --i > 0
        j = ~~(Math.random() * (i + 1))
        t = a[j]
        a[j] = a[i]
        a[i] = t
    a

  _getRandomInt: (min, max) ->
    return Math.floor(Math.random() * (max - min + 1)) + min