@Rack = class Rack extends Tile_Collection
  constructor: (letters) ->
    super

  quanity_until_full: ->
    RACK_SIZE = 7
    return (RACK_SIZE - @quantity())

  find_selected: ->
    tiles = []
    for tile in @collection
      if tile.selected == true
        tiles.push tile
    return tiles

  log: ->
    console.log @all_by_value()

  # Return string with comma separated list of tiles
  all_by_value: ->
    tiles = ""
    for tile in @all()
      tiles += (tile.value + ", ")
    return tiles
