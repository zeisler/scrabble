window.Rack = ($scope, $http) ->
  $scope.tiles = [
    {id: 0, letter: "a", score: 2, selected: false},
    {id: 1, letter: "p", score: 2, selected: false},
    {id: 2, letter: "p", score: 2, selected: false},
    {id: 3, letter: "l", score: 2, selected: false},
    {id: 4, letter: "e", score: 2, selected: false}
  ]
  $scope.new_rack = ->
    $scope.tiles = [
      {id: 0, letter: "c", score: 2, selected: false},
      {id: 1, letter: "a", score: 2, selected: false},
      {id: 2, letter: "b", score: 2, selected: false},
      {id: 3, letter: "b", score: 2, selected: false},
      {id: 4, letter: "a", score: 2, selected: false},
      {id: 5, letter: "g", score: 2, selected: false},
      {id: 6, letter: "e", score: 2, selected: false}
      ]
  $scope.shuffle_rack = ->
    shuffle_logic $scope.tiles

  $scope.is_word = ->
    word = ""
    angular.forEach $scope.tiles, (tile) ->
      if tile.selected == true
        word += tile.letter
    dictionary(word)

  dictionary = (word) ->
    $http(
      method: "GET"
      url: "/word/#{word}.json"
    ).success((data, status, headers, config) ->
      console.log data.word
      if data.word == word
        alert "Word: #{word} is a valid word."
    ).error (data, status, headers, config) ->
        alert "Word: #{word} is not a valid word."

  shuffle_logic = (a) ->
    i = a.length
    while --i > 0
        j = ~~(Math.random() * (i + 1))
        t = a[j]
        a[j] = a[i]
        a[i] = t
    return a
