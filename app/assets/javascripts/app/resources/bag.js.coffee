@Bag = class Bag extends Tile_Collection
  constructor: ->
    super()
    @scores = Tile_Scores
    @letter_distributions = Letter_Distributions
    @fill()

  take_up_to: (tiles_to_get)->
    if tiles_to_get > @quantity()
      tiles_to_get = @quantity()
    if tiles_to_get == 0
      return false
    tiles_to_return = []
    for tile in [1..tiles_to_get]
      random_index = @getRandomInt(0, ((@quantity()) - 1))
      tiles_to_return.push @remove_at(random_index)
    return tiles_to_return

  fill: ->
    unless @bag_has_been_filled?
      for letter, amounts of @letter_distributions
        range = [1..amounts]
        for id in range
          @add(new Tile letter,  @score_letters(letter))
      @bag_has_been_filled = true

  #Class Helpers
  getRandomInt: (min, max) ->
    return Math.floor(Math.random() * (max - min + 1)) + min

  #Class Resources
  score_letters: (letter) ->
    score = 0
    for score, value of @scores
      regStr = new RegExp("[#{score}]", "g")
      score = (letter.match regStr)
      if score != null
        return value