describe "board", ->
  beforeEach ->
    @board = new Board()
    @tile = new Tile("a", 4)
  it "makes a grid", ->
    expect(@board.grid.length).toEqual(15)
  it "finds center cell and adds star to bonus", ->
    width = @board.width - 1
    expect(@board.grid[(width)/2][(width)/2].bonus).toEqual('star')
  it "takes any move for first move", ->
    expect(@board.move(0,0, @tile)).toEqual true
  it "check second move to be in the same x or y", ->
    @board.move(0,0, @tile)
    expect(@board.move(0,1, @tile)).toEqual true
  it "fails if second move is not in the same x or y", ->
    @board.move(0,0, @tile)
    expect(@board.move(1,1, @tile)).toEqual false
    expect(@board.moves.length).toEqual 1
  it "make_word add to played_words if valid", ->
    @board.move(0,0, @tile)
    @board.move(0,1, @tile)
    expect(@board.make_word()).toBe true
    expect(@board.played_words.length).toEqual 1
    expect(@board.total_score).toEqual 8
  it "doesn't make a word if not valid word", ->
    @tile.value = "b"
    @board.move(0,0, @tile)
    @board.move(0,1, @tile)
    expect(@board.make_word()).toBe false
    expect(@board.played_words.length).toEqual 0
    expect(@board.total_score).toEqual 0
  it "can score word scrabble", ->
    @board.move( 0,0, _.clone(@tile.set_value("s")))
    @board.move( 0,2, _.clone(@tile.set_value("c")))
    @board.move( 0,1, _.clone(@tile.set_value("r")))
    @board.move( 0,3, _.clone(@tile.set_value("a")))
    @board.move( 0,4, _.clone(@tile.set_value("b")))
    @board.move( 0,5, _.clone(@tile.set_value("b")))
    @board.move( 0,6, _.clone(@tile.set_value("l")))
    @board.move( 0,7, _.clone(@tile.set_value("e")))
    expect(@board.make_word()).toBe true
    expect(@board.total_score).toBe 4 * 8






