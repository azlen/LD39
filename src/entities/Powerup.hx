package entities;

import luxe.Sprite;
import luxe.Vector;

import components.Glow;

import luxe.resource.Resource;
import phoenix.Texture;

import C;

class Powerup extends Sprite {

	var player : Sprite;

	var pickup_sound : AudioResource;

	var used : Bool = false;

	override public function new(position:Vector) {

		var image = Luxe.resources.texture('assets/images/battery_powerup.png');
		image.filter_min = image.filter_mag = FilterType.nearest;

		pickup_sound = Luxe.resources.audio('assets/sounds/pickup.wav');

		super({
			name: 'Powerup' + Std.string(C.unique_id()),
			texture: image,
			pos: position,
			size: new Vector(64, 64),

			depth: 9
		});

		add(new Glow(0xc0ffa0, 128));

	}

	override function init() {
		player = cast Luxe.scene.entities.get('Player');
	}

	override function update(dt:Float) {

		if(!used) {
			if(	pos.x > player.pos.x - player.size.x / 2 &&
				pos.x < player.pos.x + player.size.x / 2 &&
				pos.y > player.pos.y - player.size.y / 2 &&
				pos.y < player.pos.y + player.size.y / 2 ) {

				player.events.fire('heal', { amount: 5 });

				Luxe.audio.play(pickup_sound.source);

				self_destruct();

			}
		}

	}

	function self_destruct() {
		// instead of destroying !! >R?>EF
		visible = false;
		used = true;
		pos.set_xy(1010100, 10101000);

		// destroy();

	}

}