window.gameController = ($scope,$http) ->
  $ = $scope
  $.game = new Game
  $.rack_tiles = $.game.rack.all()
  $.bag_tiles  = $.game.bag.all()
  $.board_cells = $.game.board.grid
  $.bag = $.game.bag
  $.rack = $.game.rack
  $.board = $.game.board
  $.played_words = $.game.played_words

  $.shuffle_rack = ->
    $.game.rack.shuffle()
  $.swap_tiles = ->
    $.game.swap_tiles $.rack.find_selected()
  $.toggle_selection = ->
    tile = this.tile
    if tile.selected == true
      tile.selected = false
    else if tile.selected == false
      tile.selected = true
  $.is_word = ->
    $.game.validate_word(find_selected($.rack_tiles))
  find_selected = (collection)->
    tiles = []
    angular.forEach collection, (tile) ->
      if tile.selected == true
        tiles.push tile
    return tiles
  tiles_to_word = (tiles)->
    word = ""
    for tile in tiles
      word += tile
    return word
  selected_to_word = (collection=$.rack_tiles)->
    tiles_to_word find_selected(collection)

  # want to move out of controller and make a word model
  # that on creation of a word object valid if it is a word
  # the board will have words
  dictionary = (word) ->
    $http(
      method: "GET"
      url: "/word/#{word}.json"
    ).success((data, status, headers, config) ->
      console.log data.word
      if data.word == word
        alert "Word: #{word} is a valid word."
    ).error (data, status, headers, config) ->
        alert "Word: #{word} is not a valid word."
  $.rack_to_board = (cell_id, tile_id) ->
    tile = $.game.rack.remove_at tile_id
    $.board_cells[cell_id].tile = tile
    set_drag()

  $.cell_to_cell = (cell_id, tile_id) ->
    old_cell = tile_id[1]
    #get tile from old cell
    tile = $.board_cells[old_cell].tile
    #set old cell tile to undefined
    $.board_cells[old_cell].tile = undefined
    #set tile to new cell location
    $.board_cells[cell_id].tile = tile
    set_drag()

  set_drag = ->
    jQuery('tile').draggable()
    jQuery("cell").droppable
      accept: "tile"
      hoverClass: "cell-hover"
      drop: (event, ui) ->
        debugger
        tile = ui.helper[0]
        tile_id = tile.id
        # tile.remove()
        #rack:id OR board:id
        tile_id = tile_id.split(':',2)
        cell_id = this.id
        if tile_id[0] == "rack"
          $.rack_to_board(cell_id, tile_id)
        else if tile_id[0] == "board"
          $.cell_to_cell(cell_id, tile_id)

