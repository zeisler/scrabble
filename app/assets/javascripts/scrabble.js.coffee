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
      # tile.draggable.remove()

      $(this).html(tile.helper)
      $(tile.helper).removeAttr('style')
      $(tile.helper).css
        position: "relative"
      $(tile.helper).addClass('tile-active')
      cell = event.target

      #   position: "static"
      #   # top: $(cell)[0].offsetTop + 1
      #   # left: $(cell)[0].offsetLeft + 1
      # , 100

    $('.tile').on 'click', ->
      parent = $(this).parent()
      # if $(parent).hasClass('.cell')
