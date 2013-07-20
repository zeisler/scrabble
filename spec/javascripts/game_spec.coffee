//= require scrabble/game

describe "class Game" , ->
  beforeEach ->
    setFixtures('<div id="rack"><ul></ul></div><div id="game-board"></div>')
    @game = new Game

  describe "fill_rack", ->
    it "on init rack is filled", ->
      expect(@game.rack.quantity()).toEqual 7

  describe "swap_tiles", ->
    it "will exchanges with bag", ->
      unswaped_rack = cloneObject @game.rack.all()
      @game.swap_tiles(@game.rack.all())
      expect(@game.rack.all()).not.toEqual unswaped_rack
      expect(@game.rack.quantity()).toEqual 7
  describe "set buttons", ->
    beforeEach ->
      setFixtures('<div class="btn" id="new_rack">New Rack</div>')
      @game = new Game

    it "will bind to #new_rack and call swap_tiles", ->
      spyOn(@game, "swap_tiles")
      $('#new_rack').click()
      expect(@game.swap_tiles).toHaveBeenCalled()
    it "will bind to #new_rack and update ui with new rack", ->
      $('#new_rack').click()
      expect($('#rack')).toContain('li.tile')
