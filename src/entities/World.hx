package entities;

import luxe.Entity;

import luxe.tilemaps.Tilemap;
import luxe.options.TilemapOptions;

// import luxe.utils.Random;

import luxe.Vector;
import phoenix.Texture;

class World extends Entity {

	public var map : Tilemap;

	var floor_tiles = [3];

	override public function new() {

		super({
			name: 'World'
		});

	} // new

	override function init() {

		create_tilemap();

		generate_world();

		map.display({ scale: 4 });

	} // init

	override function update(dt:Float) {

	} // update

	function create_tilemap() {

		// create tilemap

		var tilemap_opts : TilemapOptions = {
			tile_width: 16,
			tile_height: 16,
			w: 20, // width of tilemap
			h: 20, // height of tilemap
			orientation : TilemapOrientation.ortho,
		};

		map = new Tilemap(tilemap_opts);

		// create tileset

		var image = Luxe.resources.texture('assets/images/dungeon.png');
		image.filter_min = image.filter_mag = FilterType.nearest;

		var tileset_opts : TilesetOptions = {
			name: 'dungeon',
			tile_width: 16,
			tile_height: 16,
			texture: image,
		};

		map.add_tileset(tileset_opts);

		// add layer

		map.add_layer({ name: 'world' });

	} // create_tilemap

	function generate_world() {

		map.add_tiles_fill_by_id( 'world', 3 );

		for(i in 0...10) {
			var width = Luxe.utils.random.int(2, 5);
			var height = Luxe.utils.random.int(2, 5);

			var offset_along_edge = Luxe.utils.random.int(0, map.width - Math.max(width, height));
			var edge = Luxe.utils.random.int(0, 4);

			var position = new Vector();

			switch edge {
				case 0: position.set_xy(offset_along_edge, 0); // top edge
				case 1: position.set_xy(map.width - width, offset_along_edge); // right edge
				case 2: position.set_xy(offset_along_edge, map.height - height); // bottom edge
				case 3: position.set_xy(0, offset_along_edge); // left edge
			};

			for(x_offset in 0...width) {
				for(y_offset in 0...height) {
					map.tile_at('world', Std.int(position.x + x_offset), Std.int(position.y + y_offset)).id = 1;
				}
			}
		}

		var terrain_adjacent = [
			'0,0,0,0' => 1, // !
			'1,0,0,0' => 1, // !
			'0,1,0,0' => 1, // !
			'0,0,1,0' => 1, // !
			'0,0,0,1' => 1, // !
			'1,1,0,0' => 11, // BOTTOM LEFT CORNER
			'1,0,1,0' => 1, // !
			'1,0,0,1' => 10, // BOTTOM RIGHT CORNER
			'0,1,1,0' => 17, // TOP LEFT CORNER
			'0,1,0,1' => 1, // !
			'0,0,1,1' => 18, // TOP RIGHT CORNER
			'1,1,1,0' => 9, // LEFT EDGE
			'1,1,0,1' => 8, // BOTTOM EDGE
			'1,0,1,1' => 6, // RIGHT EDGE
			'0,1,1,1' => 5, // TOP EDGE

			'1,1,1,1' => -1, // HAHA DON'T KNOW YET!
		];

		var terrain_diagonal = [ // assuming [1,1,1,1] for terrain_adjacent
			'0,0,0,0' => 1, // !
			'1,0,0,0' => 1, // !
			'0,1,0,0' => 1, // !
			'0,0,1,0' => 1, // !
			'0,0,0,1' => 1, // !
			'1,1,0,0' => 1, // !
			'1,0,1,0' => 1, // !
			'1,0,0,1' => 1, // !
			'0,1,1,0' => 1, // !
			'0,1,0,1' => 1, // !
			'0,0,1,1' => 1, // !
			'1,1,1,0' => 21, // TOP RIGHT
			'1,1,0,1' => 19, // TOP LEFT
			'1,0,1,1' => 15, // BOTTOM LEFT
			'0,1,1,1' => 16, // BOTTOM RIGHT

			'1,1,1,1' => 3, // FLOOR
		];

		for(x in 0...map.width) {
			for(y in 0...map.height) {
				var surrounding_tiles = get_surrounding_tiles(x, y);

				var i = 0;
				var adjacent_key = surrounding_tiles.filter(function(tile){
					return (i++) % 2 == 0;
				}).map(is_dungeon_tile).join(',');

				var i = 1;
				var diagonal_key = surrounding_tiles.filter(function(tile){
					return (i++) % 2 == 0;
				}).map(is_dungeon_tile).join(',');

				trace(adjacent_key);
	
				if(terrain_adjacent[adjacent_key] != -1) {
					// trace(adjacent_key);
					map.tile_at('world', x, y).id = terrain_adjacent[adjacent_key];
				}else{
					// trace(x, y, terrain_diagonal[adjacent_key]);
					map.tile_at('world', x, y).id = terrain_diagonal[diagonal_key];
				}
			}
		}
		// map.tile_at('world', 0, 0).id = 2;

	} // generate_map

	function get_surrounding_tiles(x, y) {
		var directions = [
			[-1, -1],
			[0 , -1],
			[1 , -1],
			[1 ,  0],
			[1 ,  1],
			[0 ,  1],
			[-1,  1],
			[-1,  0]
		];

		return directions.map(function(d) {
			return map.tile_at('world', x + d[0], y + d[1]);
		});
	} // get_surrounding_tiles

	inline function is_dungeon_tile(tile) {
		return (tile != null ? tile.id != 1 : false) ? 1 : 0;
	} // is_dungeon_tile

}