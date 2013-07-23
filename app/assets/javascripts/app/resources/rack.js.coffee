window.Rack = class Rack extends Tile_Collection
  quanity_until_full: ->
    rack_size = 7
    return (rack_size - @quantity())



