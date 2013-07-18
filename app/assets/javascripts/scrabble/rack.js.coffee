window.Rack = class Rack extends Tile_Collection
  constructor: ->
    super()
    @set_buttons()
  quanity_until_full: ->
    rack_size = 7
    return (rack_size - @quantity())
  on_change: (tile, where) =>
    console.log "Rack" + "::" + where
    console.log tile
    @display_rack()
  display_rack: ->
    $('#rack').find('ul').html('')
    @rack_index = 0
    tiles = @all()
    tiles_html = $('')
    for tile in tiles
      rack_tiles = $("<li class='ui-state-default btn btn-primary tile' data-index='#{@rack_index}' data-value='#{tile.value}'data-score='#{tile.score.toString()}'></li>")
      rack_tiles = $(rack_tiles).append "#{tile.value}"
      rack_tiles = $(rack_tiles).append  $("<span class='value'>#{tile.score.toString()}</span>")
      $('#rack').find('ul').append(rack_tiles).hide().show( "bounce", { times: 3 }, 1000 )
      window.setTimeout null,1000
      @rack_index += 1
    $('li.tile').draggable()
  shuffle: ->
    super()
    @display_rack()
  set_buttons: ->
    $('#suffle_rack').on 'click', =>
      @suffle()
    $('#new_rack').on 'click', ->


