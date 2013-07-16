#class Tile
  * belongs to :rack, :board
  * value: null
  * score: null

#class Rack
  * has many :tiles through :bag
  * has one bag

#class Bag
  * has many :tiles
  * belongs to :rack

#class Board
  * has a grid
  * knows position of tiles
  * knows words

#class Word
  * has many :tiles

#class rounds
  * has one or many :words

#class Game
  * has one :rack
  * has one :bag
  * has many :rounds
  * knows total score
