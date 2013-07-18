//= require scrabble/tile_collection

describe "Tile Collection" , ->
  beforeEach ->
    @collection = new Tile_Collection()
    @collection.add('A', 1)
    @collection.add('Z', 1)
  describe "all", ->
    it "returns the collection as array object", ->
      expect(typeof @collection.all()).toBe 'object'

  describe "add", ->
    it "can add tiles to the collection", ->
      expect(@collection.at(0)).toEqual { value : 'A', score : 1 }
    it "calls on_change when adding from collection", ->
      spyOn(@collection, 'on_change')
      @collection.add('G', 1)
      expect(@collection.on_change).toHaveBeenCalled()

  describe "remove_at", ->
    it "remove a tile by index", ->
      @collection.remove_at 0
      expect(@collection.quantity()).toEqual 1
    it "removes a tile from the collection and returns that tile", ->
      returned_tile = @collection.remove_at 0
      expect(returned_tile).toEqual { value : 'A', score : 1 }
     it "calls on_change when removing from collection", ->
      spyOn(@collection, 'on_change')
      @collection.remove_at 0
      expect(@collection.on_change).toHaveBeenCalled()

  describe "quantity", ->
    it "has a quantity that returns the number in the collection", ->
      expect(@collection.quantity()).toEqual 2

  describe "shuffle", ->
    it "can shuffle the collection", ->
      @collection.add('R', 1)
      @collection.add('G', 1)
      unshuffled_collection  = @collection.all()
      @collection.shuffle()
      expect(unshuffled_collection).not.toEqual @collection.all()

  describe "find_by_letter", ->
    it "can find by letter in the collection", ->
      expect(@collection.find_by_letter('A')).toEqual { value : 'A', score : 1 }


