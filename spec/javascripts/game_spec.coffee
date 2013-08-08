#describe "Game" , ->
#  beforeEach ->
#    setFixtures('<div id="rack"><ul></ul></div><div id="game-board"></div>')
#    @game = new Game
#    console.log game
#  describe "fill_rack", ->
#    it "on init rack is filled", ->
#      expect(@game.rack.quantity()).toEqual 7
#
#  describe "swap_tiles", ->
#    it "will exchanges with bag", ->
#      unswaped_rack = cloneObject @game.rack.all()
#      @game.swap_tiles(@game.rack.all())
#      expect(@game.rack.all()).not.toEqual unswaped_rack
#      expect(@game.rack.quantity()).toEqual 7
#
