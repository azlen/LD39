package entities;

import luxe.Sprite;

import components.Movement;

import luxe.Vector;

class Bullet extends Sprite {

	override public function new(position:Vector, direction:Vector) {

		super({
			pos: position,
			size: new Vector(10, 10)
		});

		var movement_component = add(new Movement());

		movement_component.direction = direction;
		movement_component.max_move_speed = 500;

	}

}