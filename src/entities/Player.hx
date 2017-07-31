package entities;

import luxe.Sprite;

import components.Movement;
import components.PlayerController;
import components.PlayerAnimation;
import components.MovementParticles;
import components.Glow;
import components.Energy;
import components.Collision;

import entities.Overlay;

import luxe.Color;
import luxe.Vector;

import phoenix.Texture;

class Player extends Sprite {

	var energy : Energy;

	var follow_light1 : Sprite;
	var follow_light2 : Sprite;

	override public function new(){

		var image = Luxe.resources.texture('assets/images/player_animation.png');
		image.filter_min = image.filter_mag = FilterType.nearest;

		// initialize player
		super({
			name: 'Player',
			texture: image,
			pos: Luxe.screen.mid,
			size: new Vector(64, 64),

			depth: 10
		});

		// attach player controller
		add(new Movement()); // handles movement
		add(new PlayerController()); // handles input
		add(new PlayerAnimation());
		energy = add(new Energy(25));

		// attach movement particles component
		// add(new MovementParticles());

		// add glow effect
		// add(new Glow(0x6abe30));
		var glow = add(new Glow(0xc0ffa0, 512));

		follow_light1 = new Sprite({
			pos: new Vector(0,0),
			size: new Vector(0,0)
		});
		follow_light1.add(new Glow(0xc0ffa0, 1024));

		follow_light2 = new Sprite({
			pos: new Vector(0,0),
			size: new Vector(0,0)
		});
		// follow_light2.add(new Glow(0xc0ffa0, 512));

		// add collision
		add(new Collision());
	}

	override function init(){
		
		events.listen('die', die);

	}//init

	override function update(dt:Float){

		follow_light1.pos.copy_from(pos);
		follow_light2.pos.copy_from(pos);

	}//update

	function die(e) {

		if(!C.PAUSED) {

			C.PAUSED = true;

			new Overlay('YOU LOSE!');
		}

	}

}//Player
