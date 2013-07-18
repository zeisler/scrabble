Array.prototype.last = (function(){
  return this.reverse()[0];
});
Array.prototype.first = (function(){
  return this[0];
});

to_array = function(obj){
  if(typeof obj === 'array'){
    return obj;
  } else {
    array = [];
    array.push(obj);
    return array;
  }
};

//+ Jonas Raoni Soares Silva
//@ http://jsfromhell.com/array/shuffle [v1.0]
shuffle = function(o){ //v1.0
    for(var j, x, i = o.length; i; j = parseInt(Math.random() * i), x = o[--i], o[i] = o[j], o[j] = x);
    return o;
};
(function() {
  var Tile;

  window.Tile = Tile = (function() {
    function Tile(value, score) {
      this.value = value;
      this.score = score;
    }

    return Tile;

  })();

}).call(this);
//# sourceMappingURL=/assets/source_maps/app/assets/javascripts/scrabble/tile.map
;
(function() {
  var Tile_Collection;

  window.Tile_Collection = Tile_Collection = (function() {
    function Tile_Collection() {
      this.collection = [];
      this.id = 0;
    }

    Tile_Collection.prototype.on_change = function(obj, msg) {
      return false;
    };

    Tile_Collection.prototype.all = function(index) {
      return this.collection;
    };

    Tile_Collection.prototype.remove_at = function(index) {
      var tile;
      tile = this.collection.splice(index, 1);
      if (tile !== -1) {
        this.on_change(tile, "remove_at");
      }
      return tile;
    };

    Tile_Collection.prototype.add = function(letter, score) {
      this.collection.push(new Tile(letter, score));
      this.id += 1;
      return this.on_change(this.collection[this.id], "add");
    };

    Tile_Collection.prototype.shuffle = function() {
      var collection;
      collection = shuffle(this.collection);
      this.collection = [];
      return this.collection.push(collection);
    };

    Tile_Collection.prototype.quantity = function() {
      return this.collection.length;
    };

    Tile_Collection.prototype.find_by_letter = function(letter) {
      var tile, _i, _len, _ref;
      _ref = this.collection;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        tile = _ref[_i];
        if (tile.value === letter) {
          return tile;
        }
      }
      return null;
    };

    Tile_Collection.prototype.at = function(index) {
      return this.collection[index];
    };

    return Tile_Collection;

  })();

}).call(this);
//# sourceMappingURL=/assets/source_maps/app/assets/javascripts/scrabble/tile_collection.map
;
(function() {
  var Bag,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  window.Bag = Bag = (function(_super) {
    __extends(Bag, _super);

    function Bag() {
      this.on_change = __bind(this.on_change, this);
      Bag.__super__.constructor.call(this);
    }

    Bag.prototype.on_change = function(obj, where) {
      console.log('Bag' + "::" + where);
      console.log(obj);
      return this.update_ui(obj);
    };

    Bag.prototype.update_ui = function(tile) {
      return console.log("bag update ui");
    };

    Bag.prototype.take_up_to = function(tiles_to_get) {
      var random_index, tile, tiles_to_return, _i;
      if (tiles_to_get > this.quantity()) {
        tiles_to_get = this.quantity();
      }
      if (tiles_to_get === 0) {
        return null;
      }
      tiles_to_return = [];
      for (tile = _i = 1; 1 <= tiles_to_get ? _i <= tiles_to_get : _i >= tiles_to_get; tile = 1 <= tiles_to_get ? ++_i : --_i) {
        random_index = this.getRandomInt(0, (this.quantity()) - 1);
        tiles_to_return.push(this.remove_at(random_index));
      }
      return tiles_to_return;
    };

    Bag.prototype.fill = function() {
      var amounts, id, letter, range, _i, _j, _len, _ref, _results;
      if (this.bag_has_been_filled == null) {
        _ref = this.letter_distributions;
        for (letter in _ref) {
          amounts = _ref[letter];
          range = (function() {
            _results = [];
            for (var _i = 1; 1 <= amounts ? _i <= amounts : _i >= amounts; 1 <= amounts ? _i++ : _i--){ _results.push(_i); }
            return _results;
          }).apply(this);
          for (_j = 0, _len = range.length; _j < _len; _j++) {
            id = range[_j];
            this.add(letter, this.score_letters(letter));
          }
        }
        return this.bag_has_been_filled = true;
      }
    };

    Bag.prototype.getRandomInt = function(min, max) {
      return Math.floor(Math.random() * (max - min + 1)) + min;
    };

    Bag.prototype.score_letters = function(letter) {
      var regStr, rule, score, value, _ref;
      score = 0;
      _ref = this.rules;
      for (rule in _ref) {
        value = _ref[rule];
        regStr = new RegExp("[" + rule + "]", "g");
        score = letter.match(regStr);
        if (score !== null) {
          return value;
        }
      }
    };

    Bag.prototype.rules = {
      _: 0,
      aeioulnrst: 1,
      dg: 2,
      bcmp: 3,
      fhvwy: 4,
      k: 5,
      jx: 8,
      qz: 10
    };

    Bag.prototype.letter_distributions = {
      '_': 2,
      'e': 12,
      'a': 9,
      'i': 9,
      'o': 8,
      'n': 6,
      'r': 6,
      't': 6,
      'l': 4,
      's': 4,
      'u': 4,
      'd': 4,
      'g': 3,
      'b': 2,
      'c': 2,
      'm': 2,
      'p': 2,
      'f': 2,
      'h': 2,
      'v': 2,
      'w': 2,
      'y': 2,
      'k': 1,
      'j': 1,
      'x': 1,
      'q': 1,
      'z': 1
    };

    return Bag;

  })(Tile_Collection);

}).call(this);
//# sourceMappingURL=/assets/source_maps/app/assets/javascripts/scrabble/bag.map
;
(function() {
  var Rack,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  window.Rack = Rack = (function(_super) {
    __extends(Rack, _super);

    function Rack() {
      this.on_change = __bind(this.on_change, this);
      Rack.__super__.constructor.call(this);
      this.set_buttons();
    }

    Rack.prototype.quanity_until_full = function() {
      var rack_size;
      rack_size = 7;
      return rack_size - this.quantity();
    };

    Rack.prototype.on_change = function(tile, where) {
      console.log("Rack" + "::" + where);
      console.log(tile);
      return this.display_rack();
    };

    Rack.prototype.display_rack = function() {
      var rack_tiles, tile, tiles, tiles_html, _i, _len;
      $('#rack').find('ul').html('');
      this.rack_index = 0;
      tiles = this.all();
      tiles_html = $('');
      for (_i = 0, _len = tiles.length; _i < _len; _i++) {
        tile = tiles[_i];
        rack_tiles = $("<li class='ui-state-default btn btn-primary tile' data-index='" + this.rack_index + "' data-value='" + tile.value + "'data-score='" + (tile.score.toString()) + "'></li>");
        rack_tiles = $(rack_tiles).append("" + tile.value);
        rack_tiles = $(rack_tiles).append($("<span class='value'>" + (tile.score.toString()) + "</span>"));
        $('#rack').find('ul').append(rack_tiles).hide().show("bounce", {
          times: 3
        }, 1000);
        window.setTimeout(null, 1000);
        this.rack_index += 1;
      }
      return $('li.tile').draggable();
    };

    Rack.prototype.shuffle = function() {
      Rack.__super__.shuffle.call(this);
      return this.display_rack();
    };

    Rack.prototype.set_buttons = function() {
      var _this = this;
      $('#suffle_rack').on('click', function() {
        return _this.suffle();
      });
      return $('#new_rack').on('click', function() {});
    };

    return Rack;

  })(Tile_Collection);

}).call(this);
//# sourceMappingURL=/assets/source_maps/app/assets/javascripts/scrabble/rack.map
;
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
(function() {
  $().ready(function() {
    var Game;
    return window.Game = Game = (function() {
      function Game() {
        this.bag = new Bag;
        this.bag.fill();
        this.rack = new Rack;
        this.fill_rack();
        this.rack.display_rack();
        this.board = new Board;
      }

      Game.prototype.fill_rack = function() {
        var number_to_fill, returned_tiles;
        number_to_fill = this.rack.quanity_until_full();
        returned_tiles = this.bag.take_up_to(number_to_fill);
        return this.rack.add(returned_tiles);
      };

      Game.prototype.swap_tiles = function(tiles) {
        var tile, _i, _len;
        tiles = this.bag.to_array(tiles);
        for (_i = 0, _len = tiles.length; _i < _len; _i++) {
          tile = tiles[_i];
          this.rack.remove(tile);
          this.bag.add(tile);
        }
        return this.fill_rack();
      };

      return Game;

    })();
  });

}).call(this);
//# sourceMappingURL=/assets/source_maps/app/assets/javascripts/scrabble/game.map
;
