//= require scrabble/rack

describe "Rack" , ->
  beforeEach ->
    @rack = new Rack

  it "calls on_change when tiles are added to collection", ->
    spyOn(@rack, "on_change")
    @rack.add(new Tile('a', 1))
    expect(@rack.on_change).toHaveBeenCalled()

