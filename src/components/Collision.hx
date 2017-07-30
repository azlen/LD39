package components;

import luxe.Component;

import luxe.Vector;
import C;

class Collision extends Component {

	var velocity : Vector;

	override public function new() {

		super({
			name: 'Collision'
		});

	} // new

	override function init() {

		velocity = entity.get('Movement').velocity;

	} // init

	override function update(dt:Float) {

		if(check_collision(velocity.x * dt, 0)) {
			entity.pos.x -= velocity.x * dt;
			velocity.x = 0;
		}
		if(check_collision(0, velocity.y * dt)) {
			entity.pos.y -= velocity.y * dt;
			velocity.y = 0;
		}

	} // update

	function check_collision(x_offset, y_offset) {

		var tile = C.world.map.tile_at_pos('world', entity.pos.x + x_offset, entity.pos.y + y_offset, 4);
		
		// trace(tile!=null?tile.id:null);
		if(tile == null || C.floor_tiles.indexOf(tile.id) == -1) { // check if tile is floor tile
			return true;
		}else{
			return false;
		}

	} // check_collision

}