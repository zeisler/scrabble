describe "Game" , ->
 beforeEach ->
   @game = new Game
 describe "fill_rack", ->
   it "on init rack is filled", ->
     expect(@game.rack.quantity()).toEqual 7

 describe "swap_tiles", ->
   it "will exchanges with bag", ->
     unswaped_rack = _.clone @game.rack.all()
     @game.swap_tiles(@game.rack.all())
     expect(@game.rack.all()).not.toEqual unswaped_rack
     expect(@game.rack.quantity()).toEqual 7

