describe "board", ->
  beforeEach ->
    @board = new Board()
    @tile = new Tile("a", 4)
  it "makes a grid", ->
    expect(@board.grid instanceof Grid).toBe true
  it "finds center cell and adds star to bonus", ->
    expect(@board.center instanceof Cell).toBe true
    expect(@board.center.bonus).toBe "star"








