@Game = class Game
  constructor: ()->
    @bag = new Bag
    @rack = new Rack
    @fill_rack()
    @board = new Board
    @log_game()
  fill_rack: ->
    number_to_fill = @rack.quanity_until_full()
    returned_tiles = @bag.take_up_to(number_to_fill)
    @rack.add_in_mass (returned_tiles)
  swap_tiles: (tiles) ->
    for tile in tiles
      unless tile == undefined
        @rack.remove_by_letter tile.value
        @bag.add(tile)
    @fill_rack()
    @log_game()

  blank: (value) ->
    tile = @rack.blank()
    if tile?
      tile.value = value
      return tile
    else
      return false

  move: (x,y,letter_from_rack) ->
    if typeof letter_from_rack is "string"
      tile = @rack.at @rack.find_by_letter letter_from_rack
    else if letter_from_rack instanceof Tile
      tile = letter_from_rack
    if @board.move(x,y, tile) && tile != undefined
      @rack.remove_at @rack.find_by_letter tile.value
      @log_game()
      return true
    else
      return false
  move_by_word: (x,y,x2,y2,word) ->
    length = word.length
    if (x - x2) == (length - 1) || (y - y2) == (length - 1)
      return false
    else
      if x == x2
        index = 0
        for y_for in [y..y2]
          @move(x,y_for,word[index])
          index += 1
      else if y == y2
        index = 0
        for x_for in [x..x2]
          @move(x_for,y,word[index])
          index += 1

  play_word: (x=null,y=null,x2=null,y2=null,word=null)->
    if x != null && word != null
      return false unless @move_by_word(x,y,x2,y2,word)
    if @board.make_word()
      @fill_rack()
      @log_game()
      return true
    else
      tiles = @board.empty_moves_from_board()
      @rack.add_in_mass tiles
      @log_game()
      return false

  log_game: ->
    @log_score()
    @log_rack()
    @log_board()
  log_score: ->
    console.log "Total Score: " + @board.total_score
  log_rack: ->
    console.log @rack.all_by_value()
  log_board: ->
    row = ""
    grid = ""
    for y in [0..(@board.width-1)] by 1
      for x in [0..(@board.width-1)] by 1
        if @board.grid[x][y].tile == undefined
          if @board.grid[x][y].bonus == "star"
            tile = '★ '
          else
            tile = "_ "
        else
          tile = @board.grid[x][y].tile.value + " "
        row += tile
      grid += row + "\n"
      row = ""
    console.log grid




@game = new Game()
