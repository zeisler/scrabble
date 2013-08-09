describe "Game" , ->
 beforeEach ->
   @game = new Game
 # stack_rack = (values) ->

 #  for tile in @game.rack.collection

 describe "fill_rack", ->
   it "on init rack is filled", ->
     expect(@game.rack.quantity()).toEqual 7

 describe "swap_tiles", ->
   it "will exchanges with bag", ->
     unswaped_rack = _.clone @game.rack.all()
     @game.swap_tiles(@game.rack.all())
     expect(@game.rack.all()).not.toEqual unswaped_rack
     expect(@game.rack.quantity()).toEqual 7
  describe "play_word", ->
    it "will play the word as a scrabble word if valid", ->
      @game.rack.collection[0].value = "t"
      @game.rack.collection[1].value = "e"
      @game.rack.collection[2].value = "a"
      expect(@game.play_word(7,7,7,9,"tea")).toBe true
  describe "move", ->
    it "takes a [x,y] and a value or tile from the rack", ->
      @game.rack.collection[0].value = "t"
      expect(@game.move(0,0,"t")).toBe true
      expect(@game.move(0,1,@game.rack.collection[1])).toBe true
    it "fails if tile no in rack", ->


  describe "blank", ->
    it "takes a value and finds a blank and subs that value", ->
      @game.rack.collection[0].value = "_"
      expect(@game.blank('a')).toBe @game.rack.collection[0]
      expect(@game.rack.collection[0].value).toEqual "a"
