package entities;

import luxe.Sprite;

import luxe.Vector;
import luxe.Input;

import entities.Bullet;

class Gun extends Sprite {

	var player : Sprite;

	var mouse_pos : Vector = new Vector(0, 0);

	override public function new() {

		super({
			name: 'Gun',
			pos: new Vector(100, 100),
			size: new Vector(40, 20),
		});

	}

	override function init() {

		player = cast Luxe.scene.entities.get('Player');

	}

	override function onmousemove(event:MouseEvent) {
	    mouse_pos = event.pos;
	}

	override function onmousedown(event:MouseEvent) {
		spawn_bullet();
	}

	override function update(dt:Float) {
		var offset = mouse_pos.clone().subtract(player.pos);
		offset.length = 50;
		pos.copy_from(player.pos).add(offset);

		radians = offset.angle2D;
	}

	function spawn_bullet() {
		var direction = pos.clone().subtract(player.pos); // actual offset
		direction.length = 1; // set length to 1 to create direction

		new Bullet(pos.clone(), direction);
	}

}