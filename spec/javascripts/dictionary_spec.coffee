describe "Dictionary", ->
  it "check if string is valid scrabble word", ->
    expect(Dictionary.is_word('aa')).toEqual true
    expect(Dictionary.is_word('bb')).toEqual false
  it "'scrabble' is valid word", ->
    expect(Dictionary.is_word('scabble')).toEqual true


