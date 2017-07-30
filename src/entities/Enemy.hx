package entities;

import luxe.Sprite;

import luxe.Vector;
import luxe.Color;

import components.Movement;
import components.PlayerAnimation;
import components.Glow;

import phoenix.Texture;

class Enemy extends Sprite {

	var movement : Movement;
	var type : String;
	var player : Sprite;

	override public function new(t:String) {

		type = t;

		var image : Texture = new Texture({id:"TEMPORARY"});
		var enemy_color = new Color().rgb(0xffffff);
		var enemy_size = new Vector(64, 64);

		switch type {
			case 'red_led':
				image = Luxe.resources.texture('assets/images/player_animation.png');
				enemy_color.rgb(0xff230f);
		}
		
		image.filter_min = image.filter_mag = FilterType.nearest;

		super({
			name: 'Enemy',
			texture: image,
			pos: new Vector(100, 100),
			size: enemy_size,
			color: enemy_color,

			depth: 10
		});

		movement = add(new Movement());

		movement.max_move_speed = 150;

		switch type {
			case 'red_led':
				add(new PlayerAnimation()); // HAHA
				add(new Glow(0xffc0a0, 512));
		}

	} // new

	override function init() {
		
		player = cast Luxe.scene.entities.get('Player');

	} // init

	override function update(dt:Float) {

		switch type {
			case 'red_led':
				var direction = player.pos.clone().subtract(pos);
				direction.length = 1;

				movement.direction = direction;
		}

	} // update

}