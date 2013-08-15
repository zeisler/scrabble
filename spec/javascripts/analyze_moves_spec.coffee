describe "Analyze Moves", ->
  beforeEach ->
    @board = new Board
    @analyze = new Analyze_Moves(@board)

  it "takes a constructor argument of Board Object", ->
    expect(@analyze.board instanceof Board).toBe true

  describe "analyze", ->

    describe "valid_move", ->

      it "checks if cell has tile already", ->
        @board.grid.get_cell(7,7).tile = new Tile('b', 1)
        @analyze = new Analyze_Moves(@board)
        expect(@analyze.valid_move( new Move(7,7, new Tile('a',1)) )).toBe false

      it "checks if subsequent moves are aligned", ->
        @board.moves.push new Move(7,7, new Tile('a',1))
        @board.moves.push new Move(8,8, new Tile('a',1))

        @analyze = new Analyze_Moves(@board)
        expect(@analyze.valid_move(new Move(8,8, new Tile('a',1)))).toBe false

    describe "valid_moves", =>

       it "checks if moves are equal or greater than one", ->
        @board.moves.push new Move(7,7, new Tile('a',1))
        @analyze = new Analyze_Moves()
        @analyze.set_up_board(@board)
        expect(@analyze.valid_moves()).toBe false

      it "check first set of moves to be center", ->
        @board.moves.push new Move(8,8, new Tile('a',1))
        @board.moves.push new Move(7,8, new Tile('a',1))
        @analyze = new Analyze_Moves(@board)
        expect(@analyze.valid_moves()).toBe false

      it "will return true if all is valid", ->
        @board.moves.push new Move(7,7, new Tile('a',1))
        @board.moves.push new Move(7,8, new Tile('a',1))
        @analyze = new Analyze_Moves(@board)
        expect(@analyze.valid_moves()).toBe true

    describe "connect_tiles", ->

      describe "connect_top_and_left", ->

        it "checks from first move to top", ->
          @board.grid.get_cell(7,7).tile = new Tile('a',1)
          @board.moves.push new Move(7,8, new Tile('a',1))
          @board.moves.push new Move(7,9, new Tile('a',1))
          @analyze.var_setup()
          @analyze.connect_top_and_left()
          expect(@analyze.moves[0] instanceof Cell).toBe true
          expect(@analyze.moves.length).toEqual 3

        it "checks from first move to left", ->
          @board.grid.get_cell(7,7).tile = new Tile('a',1)
          @board.moves.push new Move(8,7, new Tile('a',1))
          @board.moves.push new Move(9,7, new Tile('a',1))
          @analyze.var_setup()
          @analyze.connect_top_and_left()
          expect(@analyze.moves[0] instanceof Cell).toBe true
          expect(@analyze.moves.length).toEqual 3

      describe "connect_bottom_and_right", ->

        it "checks from last move to right", ->
          @board.grid.get_cell(9,8).tile = new Tile('a',1)
          @board.moves.push new Move(7,8, new Tile('a',1))
          @board.moves.push new Move(8,8, new Tile('a',1))
          @analyze.var_setup()
          @analyze.connect_bottom_and_right()
          @board.grid.log()
          expect(_.last(@analyze.moves) instanceof Cell).toBe true
          expect(@analyze.moves.length).toEqual 3

         it "checks from last move to bottom", ->
          @board.grid.get_cell(9,8).tile = new Tile('a',1)
          @board.moves.push new Move(9,6, new Tile('a',1))
          @board.moves.push new Move(9,7, new Tile('a',1))
          @analyze.var_setup()
          @analyze.connect_bottom_and_right()
          @board.grid.log()
          expect(_.last(@analyze.moves) instanceof Cell).toBe true
          expect(@analyze.moves.length).toEqual 3




