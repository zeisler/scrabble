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
