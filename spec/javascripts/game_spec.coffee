//= require scrabble/game

describe "Scrabble Game" , ->
  beforeEach ->
    setFixtures('<div id="rack"><ul></ul></div><div id="game-board"></div>')

  # it "on init rack is filled", ->
  #   game = new Game
  #   console.log game
  #   expect(game.rack.quantity()).toEqual 7
