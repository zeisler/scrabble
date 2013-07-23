window.Word = class Word
  constructor: (tiles, success_callback) ->
    # A word needs at least two letter
    if tiles.length < 2
      return false
    else
      @success_callback = success_callback
      @score = 0
      @valid = false
      @tiles = tiles
      @word = @tiles_to_word tiles
      @is_word @word
  is_word: (word) ->
    $.ajax
      type: 'GET'
      url: "/word/#{word}.json"
      dataType: 'json'
      timeout: 300
      success: (data, status) =>
        if data.word = word
          @add_score()
          @valid = true
          @success_callback(this)
      error: @error()
  success: (data) ->

  error: ->
    @valid = false

  tiles_to_word: (tiles) ->
    word = ""
    for tile in tiles
      word += tile.value
    return word

  add_score: ->
    for tile in @tiles
      @score += tile.score
