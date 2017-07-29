package components;

import luxe.Component;

import luxe.Vector;

class PlayerController extends Component {

	var movement_component : Component;

	var direction : Vector;

	override public function new() {

		super({
			name: 'PlayerController',
		});

	} // new

	override function init() {

		movement_component = cast entity.get('Movement');
		
		direction = entity.get('Movement').direction;

	} // init

	override function update(dt:Float) {
		
		// handle input

		handle_input();

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

}
