window.Tile_Collection = class Tile_Collection
  constructor: (parent)->
    @parent = parent.constructor.name
    @on_change = parent.on_change
    @tiles = []
  all: (index)->
    @tiles
  remove_at: (index) ->
    tile = @tiles.splice(index, 1)
    @on_change(@first(tile), "remove_at")
    return tile
  add: (tiles) ->
    tiles = @to_array tiles
    for tile in tiles
      length = @tiles.length
      new_length = @tiles.push tile
      if new_length > length
        @on_change(@first(tile), "add")

  quantity: ->
    @tiles.length
  remove: (tiles)->
    tiles = @to_array tiles
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
    for tile in @tiles
      if tile.id = id
        return index
      index += 1
  to_array: (element) ->
    if element.length == undefined
      array = []
      array.push element
      return array
    else
      return element

  first: (element) ->
    element = @to_array element
    return element[0]
