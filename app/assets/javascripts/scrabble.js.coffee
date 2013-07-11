$().ready ->
  grid_size = 15*15
  grid(grid_size, '#game-board')
  find_center(grid_size)
  find_edges(grid_size)

  $('li.tile').draggable()

  $(".cell").droppable
    accept: "li.tile"
    hoverClass: "cell-hover"
    drop: (event, ui)->
      tile = ui
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
