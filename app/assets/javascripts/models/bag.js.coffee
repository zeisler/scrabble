window.Bag = class Bag extends Letters

  take_up_to: (tiles_to_get)->
    if tiles_to_get > @letters.length
      tiles_to_get = @letters.length
    tiles_to_return = []
    for tile in [1..tiles_to_get]
      random_index = @getRandomInt(0, ((@letters.length) - 1))
      tiles_to_return.push @remove_at(random_index)
    return tiles_to_return

  fill: ->
    unless @bag_has_been_filled?
      id_count = 0
      for letter, amounts of @letter_distributions
        range = [1..amounts]
        for id in range
          @letters.push new Tile(letter,  @.score_by_rules(letter),id_count)
          id_count += 1
      @bag_has_been_filled = true

  #Class Helpers
  getRandomInt: (min, max) ->
    return Math.floor(Math.random() * (max - min + 1)) + min

  #Class Resources
  score_by_rules: (word) ->
    sum = 0
    for rule, value of @rules
      regStr = new RegExp("[#{rule}]", "g")
      score = (word.match regStr)
      if score?
        sum += (score.length * value)
    return sum

  rules:
    aeioulnrst: 1,
    dg: 2,
    bcmp: 3,
    fhvwy: 4,
    k: 5,
    jx: 8,
    qz: 10

  letter_distributions:
    '_': 2,
    'e': 12,
    'a': 9,
    'i': 9,
    'o': 8,
    'n': 6,
    'r': 6,
    't': 6,
    'l': 4,
    's': 4,
    'u': 4,
    'd': 4,
    'g': 3,
    'b': 2,
    'c': 2,
    'm': 2,
    'p': 2,
    'f': 2,
    'h': 2,
    'v': 2,
    'w': 2,
    'y': 2,
    'k': 1,
    'j': 1,
    'x': 1,
    'q': 1,
    'z': 1

