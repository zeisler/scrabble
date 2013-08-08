var Grid = function (size) {
    var width = Math.floor(Math.sqrt(size)),
        grid = [],
        range = _.range(0, width);
    range.forEach(function (element, index) {
        var row = index;
        grid[row] = [];
        range.forEach(function (element, index) {
            var column = index;
            grid[row][column] = new Cell(column, row);
        });
    });
    return grid;
};
