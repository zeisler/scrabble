window.Rack = class Rack extends Tile_Collection
  quanity_until_full: ->
    rack_size = 12
    return (rack_size - @quantity())
  blank: ->
    for tile in @collection
      return tile if tile.value == "_"
    return false

