package entities;

import luxe.Sprite;

import luxe.Vector;
import luxe.Color;
import luxe.Component;
import C;

import components.Energy;

import phoenix.Texture;

class PlayerEnergyBar extends Sprite {

	var energy_level : Sprite;

	var energy_component : Energy;

	override public function new() {

		var image = Luxe.resources.texture('assets/images/battery.png');
		image.filter_min = image.filter_mag = FilterType.nearest;

		super({
			name: 'PlayerEnergyBar',
			texture: image,
			pos: new Vector(96, 150),
			size: new Vector(128, 256),
			batcher: C.HUD,

			depth: 2,
		});

		energy_level = new Sprite({
			pos: new Vector(96, 258),
			size: new Vector(104, 220),
			color: new Color().rgb(0x99e550),
			batcher: C.HUD,

			depth: 1,
		});

		energy_level.centered = false;
		energy_level.origin = new Vector(52, 220);

	} // new

	override function init() {

		energy_component = cast Luxe.scene.entities.get('Player').get('Energy');

	} // init

	override function update(dt:Float) {
		
		var height = Math.max(Math.min(energy_component.value / energy_component.max_value, 1) * 220, 0);
		energy_level.size.y = energy_level.origin.y = height;
		//energy_level.origin.y = 

	} // update

}