describe "Tile Collection" , ->
  beforeEach ->
    @collection = new Tile_Collection
    @collection.add(new Tile('A', 2))
    @collection.add(new Tile('Z', 1))
  describe "all", ->
    it "returns the collection as array object", ->
      expect(typeof @collection.all()).toBe 'object'

  describe "add", ->
    it "can add tiles to the collection", ->
      expect(@collection.find_by_value('A').value).toEqual 'A'

  describe "remove_by_value", ->
    it "remove a tile by value", ->
      @collection.remove_by_value 'A'
      expect(@collection.quantity()).toEqual 1
    it "returns removed tile", ->
      returned_tile = @collection.remove_by_value 'A'
      expect(returned_tile.value).toEqual 'A'

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

      unshuffled_col = _.clone @col.all()
      @col.shuffle()
      expect(unshuffled_col).not.toEqual @col.all()

  describe "find_by_value", ->
    it "can find by value in the collection and return index", ->
      expect(@collection.find_by_value('A') instanceof Tile).toEqual true


