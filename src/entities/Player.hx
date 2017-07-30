package entities;

import luxe.Sprite;

import components.Movement;
import components.PlayerController;
import components.PlayerAnimation;
import components.MovementParticles;
import components.Glow;
import components.Energy;
import components.Collision;

import luxe.Color;
import luxe.Vector;

import phoenix.Texture;

class Player extends Sprite {

	var energy : Energy;

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

		// add collision
		add(new Collision());
	}

	override function init(){
		
		events.listen('die', die);

	}//init

	override function update(dt:Float){

	}//update

	function die(e) {

		C.state.set('Lose');
		
	}

}//Player
