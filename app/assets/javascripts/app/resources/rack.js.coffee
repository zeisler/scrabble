@Rack = class Rack extends Tile_Collection

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
    console.log @_all_by_value()

  # Return string with comma separated list of tiles
  _all_by_value: ->
    tiles = ""
    for tile in @collection
      tiles += (tile.value + ", ")
    return tiles
