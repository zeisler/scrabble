@Word = class Word
  constructor: (tiles) ->

  tiles_to_word: (tiles) ->
    word = ""
    for tile in tiles
      word += tile.value
    return word

  add_score: ->
    for tile in @tiles
      @score += tile.score
