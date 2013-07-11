$().ready ->
  grid_size = 15*15
  grid(grid_size, '#game-board')
  find_center(grid_size)
  find_edges(grid_size)

  $('#sortable').sortable()
