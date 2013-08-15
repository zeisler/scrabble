# $().ready ->
#   row = null
#   column = null
#   direction = null

#   grid_size = 15*15
#   grid(grid_size, '#game-board')
#   find_center(grid_size)
#   find_edges(grid_size)
#   move_tile_to_rack = (tile) ->
#     $(tile).removeAttr('style')
#     $('#sortable').append($(tile))
#     $(tile).css
#       position: "relative"
#   move_tile_to_cell = (cell, tile) ->
#     $(cell).html(tile)
#     $(tile).removeAttr('style')
#     $(tile).css
#       position: "relative"
#   vertical_horizontal = (cell) ->
#     if row == $(cell).data('row')
#         _direction = "horizontal"
#       else if  column == $(cell).data('column')
#         _direction = "vertical"
#     return _direction
#   word_direction = (cell, tile) ->
#     unless row?
#       row = $(cell).data('row')
#       column = $(cell).data('column')
#     else unless direction?
#       direction = vertical_horizontal(cell)
#     else
#       if vertical_horizontal(cell) != direction
#         return false
#     return true
#   $('li.tile').draggable()

#   $(".cell").droppable
#     accept: "li.tile"
#     hoverClass: "cell-hover"
#     drop: (event, ui)->
#       tile = ui.helper
#       if word_direction(this, tile)
#         move_tile_to_cell(this, tile)
#         $(tile.helper).addClass('tile-active')
#       else
#         move_tile_to_rack(tile)

#   $('.tile[data-blank="true"]').on 'click', ->
#     that = this
#     $(document).keypress (e) ->
#       letter = String.fromCharCode(e.which)
#       $(that).html(letter)
#       $(that).attr("data-letter", letter)
#       $(document).unbind('keypress')


