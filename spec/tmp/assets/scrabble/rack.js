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
