package entities;

import luxe.Sprite;

import luxe.Vector;
import luxe.Input;
import phoenix.Texture;

import entities.Bullet;

import luxe.resource.Resource;

class Gun extends Sprite {

	var player : Sprite;

	var shoot_sound : AudioResource;

	override public function new() {

		var image = Luxe.resources.texture('assets/images/gun.png');
		image.filter_min = image.filter_mag = FilterType.nearest;

		shoot_sound = Luxe.resources.audio('assets/sounds/shoot.wav');

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
		if(!C.PAUSED) {
			spawn_bullet();
		}
	}

	override function update(dt:Float) {
		if(!C.PAUSED) {
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
	}

	function spawn_bullet() {
		Luxe.audio.play(shoot_sound.source);

		var direction = pos.clone().subtract(player.pos); // actual offset
		direction.length = 1; // set length to 1 to create direction

		player.events.fire('damage', { amount: 1 });

		new Bullet(pos.clone(), direction);
	}

}