package entities;

import luxe.Sprite;

import luxe.Vector;
import luxe.Input;
import phoenix.Texture;

import entities.Bullet;

class Gun extends Sprite {

	var player : Sprite;

	override public function new() {

		var image = Luxe.resources.texture('assets/images/gun.png');
		image.filter_min = image.filter_mag = FilterType.nearest;

		super({
			name: 'Gun',
			texture: image,
			pos: new Vector(100, 100),
			size: new Vector(64, 64),

			depth: 9
		});

	}

	override function init() {

		player = cast Luxe.scene.entities.get('Player');

	}

	override function onmousedown(event:MouseEvent) {
		spawn_bullet();
	}

	override function update(dt:Float) {
		var offset = Luxe.screen.cursor.pos.clone().add(Luxe.camera.pos).subtract(player.pos);
		offset.length = 42;
		pos.copy_from(player.pos).add(offset);

		radians = offset.angle2D;

		if(rotation_z > 90 || rotation_z < -90) {
			flipy = true;
		} else {
			flipy = false;
		}

		if(rotation_z > 0) {
			depth = 11;
		} else {
			depth = 9;
		}
	}

	function spawn_bullet() {
		var direction = pos.clone().subtract(player.pos); // actual offset
		direction.length = 1; // set length to 1 to create direction

		new Bullet(pos.clone(), direction);
	}

}