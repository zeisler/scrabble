//= require scrabble/tile_collection

describe "Tile Collection" , ->
  beforeEach ->
    @collection = new Tile_Collection()
    @collection.add('A', 1)
  it "has method all that return the collection as object", ->
    expect(typeof @collection.all()).toBe 'object'
  # it "can add tiles to the collection", ->
  #   expect(@collection[0]).toEqual @tile
  # it "assigns ids to a tile when added to collection", ->
  #   expect(@collection.all()[0].id).toEqual 0
  it "remove a tile by index", ->
    @collection.remove_at 0
    expect(@collection.all().length).toEqual 0
  it "remove a tile by id", ->
    @collection.remove_by_id 0
    expect(@collection.all().length).toEqual 0
  it "has a quantity that returns the number in the collection", ->
    expect(@collection.quantity()).toEqual 1
