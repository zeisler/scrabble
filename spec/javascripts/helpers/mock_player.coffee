@Mock_Player = class Mock_Player extends Player
  constructor: (@game, @moves, @name="Mock Player") ->
    super
    @rack = new Mock_Rack(@letter_from_moves())


  get_next_move: ->
    if @moves.length > 0
      moves = _.clone @moves
      move = _.flatten moves.splice(0,1)
      @moves = moves
      point = new Point(move[0],move[1])
      @move_by_word(point,move[2],move[3])
    @play_word()

  letter_from_moves: ->
    letters = []
    for move in @moves
      for letter in move[3]
        letters.push letter
    return letters