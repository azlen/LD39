package entities;

import luxe.Sprite;

import components.Movement;
import components.Glow;

import luxe.Vector;
import phoenix.Texture;

class Bullet extends Sprite {

	override public function new(position:Vector, direction:Vector) {

		var image = Luxe.resources.texture('assets/images/bullet.png');
		image.filter_min = image.filter_mag = FilterType.nearest;

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

}