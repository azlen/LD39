package components;

import luxe.Component;

import luxe.Sprite;
import luxe.Vector;
import luxe.Color;

import C;

class Glow extends Component {

	var glow_sprite : Sprite;
	var under_glow_sprite : Sprite;

	public var diameter(default, set) : Int = 256;

	override public function new(hex:Int, ?d:Int) {

		super({
			name: 'Glow',
		});

		var image = Luxe.resources.texture('assets/images/glow.png');
		var alpha_image = Luxe.resources.texture('assets/images/glow_alpha.png');

		glow_sprite = new Sprite({
			texture: image,
			size: new Vector(diameter, diameter),
			color: new Color().rgb(hex),
			batcher: C.glow_batcher
		});

		glow_sprite.color.a = 0.6;

		#if(web)
			glow_sprite.color.a = 0.05;
		#end

		under_glow_sprite = new Sprite({
			texture: alpha_image,
			size: new Vector(diameter, diameter),
			color: new Color().rgb(hex),
			depth: 5
		});

		under_glow_sprite.color.a = 0.5;

		#if(web)
			under_glow_sprite.color.a = 0.07;
		#end

		if(d != null) {
			diameter = d;
		}

	} // new

	override function init() {

	} // init

	override function update(dt:Float) {

		glow_sprite.pos.copy_from(entity.pos);
		under_glow_sprite.pos.copy_from(entity.pos);

	} // update

	function set_diameter(new_value:Int) {

		glow_sprite.size.set_xy(new_value, new_value);
		under_glow_sprite.size.set_xy(new_value, new_value);

		return diameter = new_value;

	}

	override function ondestroy() {
		glow_sprite.destroy();
		under_glow_sprite.destroy();
	}

}