describe "Bag" , ->
  beforeEach ->
    @bag = new Bag
#  describe "fill" , ->
#    it "it can fill it's collection with 100 tiles", ->
#      @bag.fill()
#      expect(@bag.quantity()).toEqual 100
#  describe "take up to" , ->
#    it "can take up to a number of tiles at random", ->
#      @bag.fill()
#      array_of_tiles = @bag.take_up_to(7)
#      expect(array_of_tiles.length).toEqual 7
#    it "if bag has less than quantity asked in take_up_to it will return the lesser value", ->
#      for index in [0..5]
#        @bag.add(new Tile('a', index))
#      array_of_tiles = @bag.take_up_to(7)
#      expect(array_of_tiles.length).toEqual 6
#    it "if bag no tiles take_up_to will return null", ->
#      array_of_tiles = @bag.take_up_to(7)
#      expect(array_of_tiles).toBe null
#
#  describe "score letters" , ->
#    it "scores letters a-z and '_'", ->
#      expect(@bag.score_letters("_")).toEqual 0
#      expect(@bag.score_letters("a")).toEqual 1
#      expect(@bag.score_letters("d")).toEqual 2
#      expect(@bag.score_letters("b")).toEqual 3
#      expect(@bag.score_letters("f")).toEqual 4
#      expect(@bag.score_letters("k")).toEqual 5
#      expect(@bag.score_letters("j")).toEqual 8
#      expect(@bag.score_letters("q")).toEqual 10








