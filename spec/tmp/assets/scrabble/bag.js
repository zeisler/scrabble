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
