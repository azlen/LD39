package entities;

import luxe.Sprite;

import components.Movement;
import components.PlayerController;
// import components.MovementParticles;

import luxe.Color;
import luxe.Vector;

import phoenix.Texture;

class Player extends Sprite {

	override public function new(){

		var image = Luxe.resources.texture('assets/images/player_animation.png');
		image.filter_min = image.filter_mag = FilterType.nearest;

		// initialize player
		super({
			name: 'Player',
			texture: image,
			pos: Luxe.screen.mid,
			size: new Vector(64, 64)
		});

		// attach player controller
		add(new Movement()); // handles movement
		add(new PlayerController()); // handles input

		// attach movement particles component
		// add(new MovementParticles());

	}

	override function init(){
		


	}//init

	override function update(dt:Float){


	}//update

}//Player
