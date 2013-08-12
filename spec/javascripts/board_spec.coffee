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
  describe "make_word", ->
    it "add to played_words if valid", ->
      @board.move(7,7, @tile)
      @board.move(7,8, @tile)
      expect(@board.make_word()).toBe true
      expect(@board.played_words.length).toEqual 1
      expect(@board.total_score).toEqual 8
    it "doesn't make a word if first turn is not on center", ->
      @board.move(0,0, @tile)
      @board.move(0,1, @tile)
      expect(@board.make_word()).toBe false
      expect(@board.played_words.length).toEqual 0
      expect(@board.total_score).toEqual 0
    it "doesn't make a word if not valid word", ->
      @tile.value = "b"
      @board.move(7,7, @tile)
      @board.move(7,8, @tile)
      debugger
      expect(@board.make_word()).toBe false
      expect(@board.played_words.length).toEqual 0
      expect(@board.total_score).toEqual 0
    it "can score word scrabble", ->
      @board.move( 7,0, _.clone(@tile.set_value("s")))
      @board.move( 7,1, _.clone(@tile.set_value("c")))
      @board.move( 7,2, _.clone(@tile.set_value("r")))
      @board.move( 7,3, _.clone(@tile.set_value("a")))
      @board.move( 7,4, _.clone(@tile.set_value("b")))
      @board.move( 7,5, _.clone(@tile.set_value("b")))
      @board.move( 7,6, _.clone(@tile.set_value("l")))
      @board.move( 7,7, _.clone(@tile.set_value("e")))

      expect(@board.make_word()).toBe true
      expect(@board.total_score).toBe 4 * 8
  describe "sort_by_axes", ->
      it "takes an x or a y and a vector", ->
        sorted = @board.sort_by_axes("x",[{x:2}, {x:1}, {x:4}, {x:3}])
        expect(sorted).toEqual [{x:1}, {x:2}, {x:3}, {x:4}]
      it "will return same order if already in order", ->
        sorted = @board.sort_by_axes("x",[{x:1}, {x:2}, {x:3}, {x:4}])
        expect(sorted).toEqual [{x:1}, {x:2}, {x:3}, {x:4}]
  describe "find_direction_axes", ->
    it "moving in a y direction", ->
      @board.move( 7,0, _.clone(@tile.set_value("s")))
      @board.move( 7,1, _.clone(@tile.set_value("c")))
      @board.move( 7,2, _.clone(@tile.set_value("r")))
      @board.move( 7,3, _.clone(@tile.set_value("a")))
      @board.move( 7,4, _.clone(@tile.set_value("b")))
      @board.move( 7,5, _.clone(@tile.set_value("b")))
      @board.move( 7,6, _.clone(@tile.set_value("l")))
      @board.move( 7,7, _.clone(@tile.set_value("e")))
      expect(@board.find_direction_axes(@board.moves).axes).toEqual "y"
    it "moving in an x direction", ->
      @board.move( 0,7, _.clone(@tile.set_value("s")))
      @board.move( 1,7, _.clone(@tile.set_value("c")))
      @board.move( 2,7, _.clone(@tile.set_value("r")))
      @board.move( 3,7, _.clone(@tile.set_value("a")))
      @board.move( 4,7, _.clone(@tile.set_value("b")))
      @board.move( 5,7, _.clone(@tile.set_value("b")))
      @board.move( 6,7, _.clone(@tile.set_value("l")))
      @board.move( 7,7, _.clone(@tile.set_value("e")))
      expect(@board.find_direction_axes(@board.moves).axes).toEqual "x"







