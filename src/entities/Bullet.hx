package entities;

import luxe.Sprite;

import components.Movement;
import components.Glow;

import luxe.Vector;
import phoenix.Texture;
import luxe.Entity;

import luxe.resource.Resource;

import C;

class Bullet extends Sprite {

	var hit_sound : AudioResource;

	var used : Bool = false;

	override public function new(position:Vector, direction:Vector) {

		var image = Luxe.resources.texture('assets/images/bullet.png');
		image.filter_min = image.filter_mag = FilterType.nearest;

		hit_sound = Luxe.resources.audio('assets/sounds/hurt.wav');

		super({
			pos: position,
			texture: image,
			size: new Vector(64, 64),

			depth: 9
		});

		// add movement component

		var movement_component = add(new Movement());

		movement_component.direction = direction;
		movement_component.max_move_speed = 500;

		radians = direction.angle2D;

		if(rotation_z > 90 || rotation_z < -90) {
			flipx = true;
		}

		// add glow

		add(new Glow(0xc0ffa0, 128));

	}

	override function update(dt:Float) {

		// trace(enemies.length);
		if(!used) {
			for(i in 0...C.enemies_alive.length) {
				var enemy = C.enemies_alive[i];
				if(enemy == null) { continue; }
				if(	pos.x > enemy.pos.x - enemy.size.x / 2 && 
					pos.x < enemy.pos.x + enemy.size.x / 2 &&
					pos.y > enemy.pos.y - enemy.size.y / 2 &&
					pos.y < enemy.pos.y + enemy.size.y / 2 ) {

					enemy.events.fire('damage', { amount: 1 });
					// trace(enemy.events);
					self_destruct();
					// destroy();
				}
			}
		}	

		/*if(!C.world.map.bounds.point_inside(pos)) {
			destroy();
		}*/

	} // update

	function self_destruct() {
		Luxe.audio.play(hit_sound.source);

		// alternative to destroy :((
		visible = false;
		used = true;
		pos.set_xy(10000000,10000000);
		// get('Glow').destroy() can I do this at least !?>!>?#>>#@#$@

		// destroy();
	}

}