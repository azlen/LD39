package components;

import luxe.Component;

import luxe.Vector;

class Movement extends Component {

	public var max_move_speed = 200;
	var acceleration_time = 0.1;
	var deceleration_time = 0.25;

	public var is_moving = false;

	public var direction = new Vector(0, 0);
	public var velocity = new Vector(0, 0);

	override public function new() {

		super({
			name: 'Movement',
		});

	} // new

	override function init() {

	} // init

	override function update(dt:Float) {

		// move entity

		if(direction.length != 0) {
			direction.length = 1;

			accelerate(dt);

			if(is_moving == false) {
				entity.events.fire('movement.start');
			}

			is_moving = true;
		} else {
			decelerate(dt);

			if(is_moving == true) {
				entity.events.fire('movement.stop');
			}

			is_moving = false;
		}

		pos.x += velocity.x * dt;
		pos.y += velocity.y * dt;
	} // update

	function accelerate(dt:Float) {

		velocity.x += direction.x * (max_move_speed / acceleration_time) * dt;
		velocity.y += (direction.y / 2) * (max_move_speed / acceleration_time) * dt;

		if(velocity.length > max_move_speed) {
			velocity.length = max_move_speed;
		}

	} // accelerate

	function decelerate(dt:Float) {

		velocity.length = Math.max(velocity.length - (max_move_speed / deceleration_time) * dt, 0);

	} // decelerate

}
