@Board_Bonuses = ->
  {
    star: new Point(7,7),

    triple_word:
      [ new Point(0,0)
        new Point(7,0)
        new Point(14,0)
        new Point(14,7)
        new Point(0,14)
        new Point(7,14)
        new Point(14,14) ]

    triple_letter:
      [ new Point(5,2)
        new Point(9,2)
        new Point(1,5)
        new Point(5,5)
        new Point(9,5)
        new Point(13,5)
        new Point(2,9)
        new Point(5,9)
        new Point(9,9)
        new Point(13,9)
        new Point(5,13)
        new Point(9,13) ]


    double_word:
      [ new Point(1,1)
        new Point(1,1) ]

    double_letter:
      [ new Point(1,1)
        new Point(1,1) ]

  }
