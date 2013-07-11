$().ready ->
  row = null
  column = null
  grid_size = 15*15
  grid(grid_size, '#game-board')
  find_center(grid_size)
  find_edges(grid_size)

  letter_dectect = (cell, tile) ->
    unless row?
      row ?= $(cell).data('row')
      column ?= $(cell).data('column')
    else
      row_next = $(cell).data('row')
      column_next = $(cell).data('column')
      unless row_next == row || column_next == column
        $(tile).removeAttr('style')
        $('#sortable').append($(tile))
        $(tile).css
          position: "relative"
        return false
    return true
  $('li.tile').draggable()

  $(".cell").droppable
    accept: "li.tile"
    hoverClass: "cell-hover"
    drop: (event, ui)->
      tile = ui
      good_play = letter_dectect(this, tile.helper)
      if good_play
        $(this).html(tile.helper)
        $(tile.helper).removeAttr('style')
        $(tile.helper).css
          position: "relative"
        $(tile.helper).addClass('tile-active')

  $('.tile[data-blank="true"]').on 'click', ->
    that = this
    $(document).keypress (e) ->
      letter = String.fromCharCode(e.which)
      $(that).html(letter)
      $(that).attr("data-letter", letter)
      $(document).unbind('keypress')


