package entities;

import luxe.Sprite;

import luxe.Vector;
import luxe.Color;

import components.Movement;
import components.PlayerAnimation;
import components.Glow;
import components.Collision;
import components.Energy;
import components.MicrochipAnimation;

import phoenix.Texture;

import C;

class Enemy extends Sprite {

	var movement : Movement;
	var type : String;
	var player : Sprite;

	var state : String;

	override public function new(t:String, position:Vector) {

		type = t;

		var image : Texture = new Texture({id:"TEMPORARY"});
		var enemy_color = new Color().rgb(0xffffff);
		var enemy_size = new Vector(64, 64);

		switch type {
			case 'red_led':
				image = Luxe.resources.texture('assets/images/red_led_enemy.png');

			case 'microchip':
				image = Luxe.resources.texture('assets/images/microchip.png');
		}
		
		image.filter_min = image.filter_mag = FilterType.nearest;

		super({
			name: 'Enemy.' + Std.string(C.unique_id()),
			texture: image,
			pos: position,
			size: enemy_size,
			color: enemy_color,

			depth: 10
		});

		movement = add(new Movement());
		add(new Collision());

		movement.max_move_speed = 150;

		var hp = 1;

		switch type {
			case 'red_led':
				add(new PlayerAnimation()); // HAHA
				// add(new Glow(0xffc0a0, 512));
				hp = 4;

			case 'microchip':
				add(new MicrochipAnimation()); // HAHA
				// add(new Glow(0xffc0a0, 512));
				hp = 2;
		}

		add(new Energy(hp));

		C.enemies_alive.push(this);

	} // new

	override function init() {
		
		player = cast Luxe.scene.entities.get('Player');

		events.listen('die', die);

		switch type {
			case 'red_led':
				state = 'wandering';

			case 'microchip':
				state = 'wandering';
		}

	} // init

	override function update(dt:Float) {

		switch state {
			case 'wandering':
				if(movement.direction.length == 0) {
					movement.direction.x = 1;
					movement.direction.angle2D = Luxe.utils.random.int(0, 2 * Math.PI);
				}
				movement.max_move_speed = 50;
				movement.direction.angle2D += Luxe.utils.random.float(-0.45, 0.45);

			case 'chasing':
				movement.max_move_speed = 140;

				var direction = player.pos.clone().subtract(pos);
				direction.length = 1;

				movement.direction = direction;
		}

		switch type {
			case 'red_led':
				if(state == 'wandering' && (get('Energy').value < 4 || pos.clone().subtract(player.pos).length < 300)) {
					state = 'chasing';
				}

			case 'microchip':
				if(state == 'wandering' && (get('Energy').value < 2 || pos.clone().subtract(player.pos).length < 200)) {
					state = 'chasing';
				}
		}

	} // update

	function die(e) {
		C.enemies_alive.remove(this);

		destroy();
	}

}