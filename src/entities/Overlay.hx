package entities;

import luxe.Entity;

import luxe.Sprite;
import luxe.Color;
import luxe.Text;

class Overlay extends Entity {

	var text : Text;
	var darkness : Sprite;

	override public function new(?message:String = '') {

		super({
			name: 'Overlay'
		});

		darkness = new Sprite({
			pos: Luxe.camera.center,
			size: Luxe.screen.size,
			color: new Color(0, 0, 0, 0.8),

			depth: 100
		});

		text = new Text({
			pos : Luxe.camera.center,
			point_size : 48,
			depth : 101,
			align : TextAlign.center,
			text : message,
			color : new Color().rgb(0xffffff)
		});

	}

}