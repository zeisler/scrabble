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
  describe("Tile Collection", function() {
    beforeEach(function() {
      this.collection = new Tile_Collection();
      this.collection.add('A', 1);
      return this.collection.add('Z', 1);
    });
    it("has method all that return the collection as array object", function() {
      return expect(typeof this.collection.all()).toBe('object');
    });
    it("can add tiles to the collection", function() {
      return expect(this.collection.at(0)).toEqual({
        value: 'A',
        score: 1
      });
    });
    it("has a quantity that returns the number in the collection", function() {
      return expect(this.collection.quantity()).toEqual(2);
    });
    it("remove a tile by index", function() {
      this.collection.remove_at(0);
      return expect(this.collection.quantity()).toEqual(1);
    });
    it("can shuffle the collection", function() {
      var unshuffled_collection;
      this.collection.add('R', 1);
      this.collection.add('G', 1);
      unshuffled_collection = this.collection.all();
      this.collection.shuffle();
      return expect(unshuffled_collection).not.toEqual(this.collection.all());
    });
    it("calls on_change when adding from collection", function() {
      spyOn(this.collection, 'on_change');
      this.collection.add('G', 1);
      return expect(this.collection.on_change).toHaveBeenCalled();
    });
    it("calls on_change when removing from collection", function() {
      spyOn(this.collection, 'on_change');
      this.collection.remove_at(0);
      return expect(this.collection.on_change).toHaveBeenCalled();
    });
    return it("can find by letter in the collection", function() {
      return expect(this.collection.find_by_letter('A')).toEqual({
        value: 'A',
        score: 1
      });
    });
  });

}).call(this);
//# sourceMappingURL=/assets/source_maps/spec/javascripts/tiles_collection_spec.map
;
