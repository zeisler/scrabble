window.Rack = class Rack
  constructor: ->
    @tiles = new Tile_Collection(this)
    @rack_index = 0
  quanity_until_full: ->
    rack_size = 7
    return (rack_size - @tiles.quantity())
  on_change: (tile, where) =>
    console.log "Rack" + "::" + where
    console.log tile
    @update_rack(tile)
  update_rack: (tile) ->
    console.debug tile
    if tile.score == 0
      score = 0
    else
      score = tile.score
    rack_tiles = $("<li class='ui-state-default btn btn-primary tile' data-index='#{@rack_index}' data-value='#{tile.value}'data-score='#{score.toString()}'></li>")
    rack_tiles = rack_tiles.append "#{tile.value}"
    rack_tiles = rack_tiles.append  $("<span class='value'>#{score.toString()}</span>")
    $('#rack').find('ul').append rack_tiles
    @rack_index += 1
