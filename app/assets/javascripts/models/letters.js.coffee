window.Letters = class Letters
  constructor: ->
    @letters = []
  remove_at: (index) ->
    @letters.splice(index, 1)
  add: (tiles) ->
    tiles = @to_array tiles
    for tile in tiles
      @letters.push tile
  quantity: ->
    @letters.length
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
    for tile in @letters
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
