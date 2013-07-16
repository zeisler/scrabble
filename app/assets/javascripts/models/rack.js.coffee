window.Rack = class Rack extends Letters

  quantity: ->
    @letters.length
  quanity_until_full: ->
    rack_size = 7
    return (rack_size - @letters.length)

