package components;

import luxe.Component;

import luxe.Vector;
import luxe.components.sprite.SpriteAnimation;

class PlayerAnimation extends Component {

	var direction : Vector;
	var velocity : Vector;
	var anim : SpriteAnimation;

	override public function new() {

		super({
			name: 'PlayerAnimation',
		});

	} // new

	override function init() {

		direction = entity.get('Movement').direction;
		velocity = entity.get('Movement').velocity;

		create_animation();

	} // init

	override function update(dt:Float) {
		
		// update animation
		update_animation();

	} // update

	function create_animation() {
		anim = entity.add(new SpriteAnimation({ name: 'SpriteAnimation' }));
		var anim_data = Luxe.resources.json('assets/animations/player_animation.json').asset.json;
	    anim.add_from_json_object( anim_data );
	    set_animation('idle_side');
	    anim.play();
	} // create_animation

	function update_animation() {
		if(velocity.length > 0) {
			if(velocity.x != 0) {
				set_animation('walk_side');
			}else {
				if(velocity.y > 0) {
					set_animation('walk_front');
				}else {
					set_animation('walk_back');
				}
			}
		}else {
			switch anim.animation {
				case 'walk_side': set_animation('idle_side');
				case 'walk_front': set_animation('idle_front');
				case 'walk_back': set_animation('idle_back');
			}
		}
	} // update_animation

	inline function set_animation(name:String) {
		if(anim.animation != name) {
			anim.animation = name;
		}
	} // set_animation
}
