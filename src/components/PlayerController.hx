package components;

import luxe.Component;

import luxe.Vector;
import luxe.components.sprite.SpriteAnimation;

class PlayerController extends Component {

	var movement_component : Component;
	var direction : Vector;
	var velocity : Vector;
	var anim : SpriteAnimation;

	override public function new() {

		super({
			name: 'PlayerController',
		});

	} // new

	override function init() {

		movement_component = cast entity.get('Movement');
		direction = entity.get('Movement').direction;
		velocity = entity.get('Movement').velocity;

		create_animation();

	} // init

	override function update(dt:Float) {
		
		// handle input
		handle_input();

		// update animation
		update_animation();

	} // update

	function handle_input() {
		if(Luxe.input.inputpressed('left')) {
			direction.x = -1;
		}
		if(Luxe.input.inputreleased('left')) {
			if(Luxe.input.inputdown('right')) {
				direction.x = 1;
			}else{
				direction.x = 0;
			}	
		}

		if(Luxe.input.inputpressed('right')) {
			direction.x = 1;
		}
		if(Luxe.input.inputreleased('right')) {
			if(Luxe.input.inputdown('left')) {
				direction.x = -1;
			}else{
				direction.x = 0;
			}
		}

		if(Luxe.input.inputpressed('up')) {
			direction.y = -1;
		}
		if(Luxe.input.inputreleased('up')) {
			if(Luxe.input.inputdown('down')) {
				direction.y = 1;
			}else{
				direction.y = 0;
			}
		}

		if(Luxe.input.inputpressed('down')) {
			direction.y = 1;
		}
		if(Luxe.input.inputreleased('down')) {
			if(Luxe.input.inputdown('up')) {
				direction.y = -1;
			}else{
				direction.y = 0;
			}
		}
	} // handle_input

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
