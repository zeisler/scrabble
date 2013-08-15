describe "Scrabble", ->
  beforeEach ->
    @game = new Game
    @moves = Mock_Moves()
    @game.add_player( new Mock_Player(@game,@moves))

  it "calls get_next_move", ->
    @game.get_next_move()

