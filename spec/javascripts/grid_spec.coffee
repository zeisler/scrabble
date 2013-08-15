describe "Grid", ->
  beforeEach ->
    @width = 15
    @grid_size = @width*@width
    @grid = new Grid(@grid_size)
  it "takes a constructor argument of grid size", ->
    expect(@grid.GRID_SIZE).toEqual @grid_size
    expect(@grid.grid.length).toEqual @grid_size
  it "has a width attribute", ->
    expect(@grid.width).toEqual @width
  describe "get_cell", ->
    it "takes x, y as arguments and return that cell", ->
      cell = @grid.get_cell(7,7)
      expect(cell.x).toEqual 7
      expect(cell.y).toEqual 7

      cell = @grid.get_cell(14,0)
      expect(cell.x).toEqual 14
      expect(cell.y).toEqual 0

      cell = @grid.get_cell(14,14)
      expect(cell.x).toEqual 14
      expect(cell.y).toEqual 14
  describe "get_cell_by_key", ->
    it "takes keys: x, y", ->
      cell = @grid.get_cell_by_key({x:7,y:8})
      expect(cell.x).toEqual 7
      expect(cell.y).toEqual 8
      cell = @grid.get_cell_by_key({y:8, x:9})
      expect(cell.x).toEqual 9
      expect(cell.y).toEqual 8



