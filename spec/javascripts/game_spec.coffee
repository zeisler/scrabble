describe "Game" , ->
 beforeEach ->
   @game = new Game
   @stack_rack = (values) ->
    index = 0
    for value in values
      @game.rack.all()[index].value = value
      index += 1
 describe "fill_rack", ->
   it "on init rack is filled", ->
     expect(@game.rack.quantity()).toEqual 7
 describe "swap_tiles", ->
   it "will exchanges with bag", ->
     unswaped_rack = _.clone @game.rack.all()
     @game.swap_tiles(@game.rack.all())
     expect(@game.rack.all()).not.toEqual unswaped_rack
     expect(@game.rack.quantity()).toEqual 7
  describe "blank", ->
    it "takes a value and finds a blank and subs that value", ->
      @stack_rack "_"
      expect(@game.blank('a')).toBe @game.rack.collection[0]
      expect(@game.rack.collection[0].value).toEqual "a"
  describe "play_word", ->
    it "will play the word as a scrabble word if valid", ->
      @stack_rack("tea")
      expect(@game.play_word(7,7,7,9,"tea")).toBe true
  describe "move", ->
    it "takes a [x,y] and a value or tile from the rack", ->
      @stack_rack "t"
      expect(@game.move(0,0,"t")).toBe true
      expect(@game.move(0,1,@game.rack.collection[1])).toBe true
    it "fails if tile not in rack", ->
      @stack_rack "zzzzzzz"
      expect(@game.move(0,0,"t")).toBe false
  describe "move by word", ->
    it "it takes a start point, an end point and a word", ->
      @stack_rack("cabbage")
      expect((@game.move_by_word 7,7,13,7,"cabbage").length).toBe 7
      expect(@game.play_word()).toBe true
      expect(@game.board.played_words.length).toEqual 1
  describe "connect_other_words_with_moves", ->
    it "checks middle of new word for connecting words", ->
      @stack_rack("cabbage")
      @game.move_by_word 7,7,13,7,"cabbage"
      @game.play_word()
      @stack_rack("rae")#rage
      @game.move_by_word 12,5,12,6,"ra"
      @game.move(12,8,"e")
      expect(@game.play_word()).toBe true
      expect((@game.board.played_words).length).toEqual(2)
    it "checks before word for connecting word", ->
      @stack_rack("apple")
      @game.move_by_word 7,7,11,7,"apple"
      @game.play_word()
      @stack_rack("lease")
      @game.move_by_word 8,8,8,12,"lease"
      expect(@game.play_word()).toEqual true
      expect((@game.board.played_words).length).toEqual(2)
    it "checks after word for connecting words", ->
      @stack_rack("dog")
      @game.move_by_word 7,7,9,7,"dog"
      @game.play_word()
      @stack_rack("go")
      @game.move_by_word 7,5,7,6,"go"
      expect(@game.play_word()).toEqual true
      expect((@game.board.played_words).length).toEqual(2)
  describe "adjacent_words", ->
    it "", ->
      #an
      #be
      #at
      @stack_rack("aba")
      @game.move_by_word 7,7,7,9,"aba"
      @game.play_word()
      @stack_rack("net")
      @game.move_by_word 8,7,8,9,"net"
      debugger
      @game.play_word()
      expect((@game.board.played_words).length).toEqual(5)





