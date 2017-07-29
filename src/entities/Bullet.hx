package entities;

import luxe.Sprite;

import components.Movement;

import luxe.Vector;
import phoenix.Texture;

class Bullet extends Sprite {

	override public function new(position:Vector, direction:Vector) {

		var image = Luxe.resources.texture('assets/images/bullet.png');
		image.filter_min = image.filter_mag = FilterType.nearest;

		super({
			pos: position,
			texture: image,
			size: new Vector(64, 64)
		});

		var movement_component = add(new Movement());

		movement_component.direction = direction;
		movement_component.max_move_speed = 500;

		radians = direction.angle2D;

	}

}