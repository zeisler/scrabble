describe "Dictionary", ->
  it "check if string is valid scrabble word", ->
    expect(Dictionary.word('aa')).toEqual true
    expect(Dictionary.word('bb')).toEqual false
  it "'scrabble' is valid word", ->
    expect(Dictionary.word('scabble')).toEqual true


