describe "Player", ->

  describe "constructor", ->

    beforeEach ->
      @player = new Player("game", "Test_Player")

    it "takes a game", ->
      expect(@player.game).toEqual "game"

    it "takes a an optional name", ->
      expect(@player.name).toEqual "Test_Player"

    it "creates a Rack object", ->
      expect(@player.rack instanceof Rack).toBe true

    it "create a score and sets it to zero", ->
      expect(@player.score).toEqual 0

  describe "Public Methods", ->

    beforeEach ->
      @game = jasmine.createSpyObj('game', ['move', 'play_word', 'swap_tiles'])
      @player = new Player(@game, "Test_Player")
      spyOn(@player.rack, 'remove_by_value').andReturn(new Tile())

    describe "move", ->

      it "removes tiles from rack by value", ->
        @player.move(0,0,"t")
        expect(@player.rack.remove_by_value).toHaveBeenCalledWith("t")

      it "sends Move to game", ->
        @player.move(0,0,"t")
        expect(@player.game.move).toHaveBeenCalled

    describe "play_word", ->

      it "calls game.play_word", ->
        @player.play_word()
        expect(@player.game.play).toHaveBeenCalled

    describe "swap_tiles", ->

      it "calls game.swap_tiles", ->
        @player.swap_tiles()
        expect(@player.game.swap_tiles).toHaveBeenCalled






