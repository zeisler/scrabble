describe "Game" , ->
 beforeEach ->
   @game = new Game
   @stack_rack = (values) ->
    index = 0
    for value in values
      @game.player.rack.all()[index].value = value
      index += 1
 describe "fill_rack", ->
   xit "on init rack is filled", ->
 describe "swap_tiles", ->
   xit "will exchanges with bag", ->
     unswaped_rack = _.clone @game.player.rack.all()
     @game.swap_by_value(@game.player.rack.all())
  describe "play_word", ->
    xit "will play the word as a scrabble word if valid", ->
      @stack_rack("tea")
  describe "move", ->
    xit "takes a [x,y] and a value or tile from the rack", ->
      @stack_rack "t"
    xit "fails if tile not in rack", ->
      @stack_rack "zzzzzzz"
  describe "move by word", ->
    xit "it takes a start point, an end point and a word", ->
      @stack_rack("cabbage")
  describe "connect_other_words_with_moves", ->
    xit "checks middle of new word for connecting words", ->
      @stack_rack("cabbage")
      @game.player.move_by_word 7,7,13,7,"cabbage"
      @game.player.play_word()
      @stack_rack("rae")#rage
      @game.player.move_by_word 12,5,12,6,"ra"
      @game.player.move(12,8,"e")
    xit "checks before word for connecting word", ->
      @stack_rack("apple")
      @game.player.move_by_word 7,7,11,7,"apple"
      @game.player.play_word()
      @stack_rack("lease")
      @game.player.move_by_word 8,8,8,12,"lease"
    xit "checks after word for connecting words", ->
      @stack_rack("dog")
      @game.player.move_by_word 7,7,9,7,"dog"
      @game.player.play_word()
      @stack_rack("go")
      @game.player.move_by_word 7,5,7,6,"go"
  describe "adjacent_words", ->
    xit "", ->
      #an
      #be
      #at
      @stack_rack("aba")
      @game.player.move_by_word 7,7,7,9,"aba"
      @game.player.play_word()
      @stack_rack("net")
      @game.player.move_by_word 8,7,8,9,"net"
      @game.player.play_word()





