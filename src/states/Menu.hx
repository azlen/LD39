package states;

import luxe.States;

import luxe.Sprite;
import phoenix.Texture;
import luxe.Vector;

import C;

class Menu extends State {

	var title_screen : Sprite;
	var press_any_key : Sprite;

	var dt_counter : Float;

	override public function new() {
		super({
			name: 'Menu'
		});
	} // new

	override function onenter<T>(_:T){

		var title_screen_image = Luxe.resources.texture('assets/images/title_screen.png');
		title_screen_image.filter_min = title_screen_image.filter_mag = FilterType.nearest;

		title_screen = new Sprite({
			pos: Luxe.screen.mid,
			size: new Vector(640, 640),
			texture: title_screen_image,

			depth: 1
		});

		var press_any_key_image = Luxe.resources.texture('assets/images/press_any_key.png');
		press_any_key_image.filter_min = press_any_key_image.filter_mag = FilterType.nearest;

		press_any_key = new Sprite({
			pos: Luxe.screen.mid,
			size: new Vector(640, 640),
			texture: press_any_key_image,

			depth: 2
		});

		// press_any_key.visible = false;

	} // onenter

	override function onleave<T>(_:T){

		title_screen.destroy();
		press_any_key.destroy();

	} // onleave

	override function update(dt:Float){

		dt_counter += dt;

		if(dt_counter > 1) {
			dt_counter = 0;

			trace(press_any_key.visible);

			press_any_key.visible = !press_any_key.visible;
		} 

	}//update

	override function onkeyup(e) {

		C.state.set('Game');

	}

}//Menu
