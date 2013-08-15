@Bag = class Bag extends Tile_Collection
  constructor: ->
    super()
    @fill()

  # Reads from Letter_Distributions to determine how to fill bag
  fill: ->
    unless @bag_has_been_filled?
      @scores = Tile_Scores()
      @letter_distributions = Letter_Distributions()
      for letter, amounts of @letter_distributions
        for index in [1..amounts]
          @add(new Tile(letter,  @score_letters(letter)))
      @bag_has_been_filled = true

  #Class Resources
  score_letters: (letter) ->
    score = 0
    for score, value of @scores
      regStr = new RegExp("[#{score}]", "g")
      score = (letter.match regStr)
      if score != null
        return value