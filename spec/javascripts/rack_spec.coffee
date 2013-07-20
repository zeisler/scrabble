//= require scrabble/rack

describe "class Rack" , ->
  beforeEach ->
    @rack = new Rack
  describe "on change", ->
    it "calls on_change when tiles are added to collection", ->
      spyOn(@rack, "on_change")
      @rack.add(new Tile('a', 1))
      expect(@rack.on_change).toHaveBeenCalled()
  describe "quantity until full", ->
    it "return how many until rack has 7 tiles", ->
      expect(@rack.quantity_until_full()).toEqual 7
      @rack.add(new Tile("a", 5))
      expect(@rack.quantity_until_full()).toEqual 6
  describe "display_rack", ->
    beforeEach ->
      setFixtures('<div id="rack"><ul></ul></div><div id="game-board"></div>')
      @rack = new Rack
      @rack.add(new Tile("A", 5))

    it "given a tile object it will be added to #rack", ->
      @rack.make_tile_html(new Tile("A", 5))
      expect($('#rack')).toContainText('A')
    it "will be called on add", ->
      expect($('#rack')).toContainText('A')
    it "will be called on remove", ->
      @rack.remove_by_letter("A")
      expect($('#rack')).toContainText('A')

