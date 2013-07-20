//= require scrabble/tile_collection

describe "class Tile Collection" , ->
  beforeEach ->
    @collection = new Tile_Collection()
    @collection.add(new Tile('A', 2))
    @collection.add(new Tile('Z', 1))
  describe "all", ->
    it "returns the collection as array object", ->
      expect(typeof @collection.all()).toBe 'object'

  describe "add", ->
    it "can add tiles to the collection", ->
      expect(@collection.at(0)).toEqual { value : 'A', score : 2 }
    it "calls on_change when adding from collection", ->
      spyOn(@collection, 'on_change')
      @collection.add(new Tile('G', 1))
      expect(@collection.on_change).toHaveBeenCalled()

  describe "remove_at", ->
    it "remove a tile by index", ->
      @collection.remove_at 0
      expect(@collection.quantity()).toEqual 1
    it "removes a tile from the collection and returns that tile", ->
      returned_tile = @collection.remove_at 0
      expect(returned_tile).toEqual { value : 'A', score : 2 }
     it "calls on_change when removing from collection", ->
      spyOn(@collection, 'on_change')
      @collection.remove_at 0
      expect(@collection.on_change).toHaveBeenCalled()

  describe "quantity", ->
    it "has a quantity that returns the number in the collection", ->
      expect(@collection.quantity()).toEqual 2

  describe "shuffle", ->
    it "can shuffle the collection", ->
      @col = new Tile_Collection()

      @col.add(new Tile('A', 2))
      @col.add(new Tile('Z', 1))
      @col.add(new Tile('S', 1))
      @col.add(new Tile('Q', 1))
      @col.add(new Tile('W', 1))
      @col.add(new Tile('F', 1))
      @col.add(new Tile('G', 1))
      @col.add(new Tile('Y', 1))

      unshuffled_col = cloneObject @col.all()
      @col.shuffle()
      expect(unshuffled_col).not.toEqual @col.all()

  describe "find_by_letter", ->
    it "can find by letter in the collection and return index", ->
      expect(@collection.find_by_letter('A')).toEqual 0


