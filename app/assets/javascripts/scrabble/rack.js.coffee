window.Rack = class Rack extends Tile_Collection
  constructor: ->
    super()
    @set_buttons()
    @delay = 0
    @rack_index = 0
  quantity_until_full: ->
    rack_size = 7
    return (rack_size - @quantity())
  on_change: (tile, where) =>
    console.log "Rack" + "::" + where
    console.log tile 
    if tile == undefined
      return null
    else if where == "remove_at"
      @remove_from_display(tile)
    else if where == "add"
      @display_rack(tile)
  remove_from_display: (tile) ->
    $(".tile[data-value='#{tile.first().value}']").first().remove()
  display_rack: (tile)->
    # $('#rack').find('ul').html('')
    @make_tile_html(tile)
    # window.setTimeout(@make_tile_html(tile),1000)
    $('li.tile').draggable()
  make_tile_html: (tile) ->
    if tile != undefined
      if @rack_index == 7
        @rack_index = 0
        $('#rack').find('ul').html('')

      @delay += 500
      rack_tiles = $("<li id='#{@rack_index}' class='ui-state-default btn btn-primary tile' data-index='#{@rack_index}' data-value='#{tile.value}'data-score='#{tile.score}'></li>")
      rack_tiles = $(rack_tiles).append "#{tile.value}"
      rack_tiles = $(rack_tiles).append  $("<span class='value'>#{tile.score}</span>")
      rack_tiles = rack_tiles
      @rack_queue = $('#rack').find('ul')
      $(@rack_queue).append(rack_tiles)

      # rack_tiles.toggle( "bounce", { times: 3 }, @delay )
      @rack_index += 1
  shuffle: ->
    super()
    @display_rack()
  set_buttons: ->
    $('#shuffle_rack').on 'click', =>
      @shuffle()
    $('#new_rack').on 'click', ->



