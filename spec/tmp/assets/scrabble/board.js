(function() {
  var Board;

  window.Board = Board = (function() {
    function Board(grid_size, html_id) {
      if (grid_size == null) {
        grid_size = 225;
      }
      if (html_id == null) {
        html_id = "game-board";
      }
      this.grid_size = grid_size;
      this.html_id = html_id;
      this.id = "#" + this.html_id;
      this.grid();
      this.find_center();
      this.find_edges();
      this.ui_drag_drop();
    }

    Board.prototype.ui_drag_drop = function() {
      $(".cell").droppable;
      return {
        accept: "li.tile",
        hoverClass: "cell-hover",
        drop: function(event, ui) {
          var tile;
          tile = ui.helper;
          if (word_direction(this, tile)) {
            move_tile_to_cell(this, tile);
            return $(tile.helper).addClass('tile-active');
          } else {
            return move_tile_to_rack(tile);
          }
        }
      };
    };

    Board.prototype.grid = function() {
      var column, columns, div_row, grid, row, rows, width, _i, _j, _k, _len, _len1, _results;
      width = Math.sqrt(this.grid_size);
      columns = rows = (function() {
        _results = [];
        for (var _i = 1; 1 <= width ? _i <= width : _i >= width; 1 <= width ? _i++ : _i--){ _results.push(_i); }
        return _results;
      }).apply(this);
      grid = $("<div id='" + this.html_id + "'></div>");
      for (_j = 0, _len = rows.length; _j < _len; _j++) {
        row = rows[_j];
        div_row = $("<div class='row' id='" + row + "'></div>");
        for (_k = 0, _len1 = columns.length; _k < _len1; _k++) {
          column = columns[_k];
          div_row.append($("<div class=\"cell\" data-row=\"" + row + "\" data-column=\"" + column + "\"></div>"));
        }
        grid.append(div_row);
      }
      return $(this.id).append(grid);
    };

    Board.prototype.find_center = function(grid_size) {
      var center;
      this.grid_size = grid_size;
      center = $(this.id).find('.cell')[(this.grid_size - 1) / 2];
      return $(center).html($('<i class="icon-star"></i>'));
    };

    Board.prototype.find_edges = function(grid_size) {
      var left_bottom, left_top, right_bottom, right_top, width;
      this.grid_size = grid_size;
      width = Math.sqrt(this.grid_size);
      left_top = $(this.id).find('.cell')[0];
      right_top = $(this.id).find('.cell')[width - 1];
      left_bottom = $(this.id).find('.cell')[(this.grid_size - 1) - (width - 1)];
      right_bottom = $(this.id).find('.cell')[this.grid_size - 1];
      $(left_top).addClass('left_top');
      $(right_top).addClass('right_top');
      $(left_bottom).addClass('left_bottom');
      return $(right_bottom).addClass('right_bottom');
    };

    return Board;

  })();

}).call(this);
//# sourceMappingURL=/assets/source_maps/app/assets/javascripts/scrabble/board.map
;
