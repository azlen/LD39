package components;

import luxe.Component;

import luxe.Vector;
import luxe.Sprite;

import C;

class Movement extends Component {

	var sprite : Sprite;

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

		sprite = cast entity;

		sprite.events.listen('hurt', knockback);

	} // init

	override function update(dt:Float) {

		// move sprite

		if(direction.x > 0) {
			sprite.flipx = false;
		}else if(direction.x < 0) {
			sprite.flipx = true;
		}

		if(!C.PAUSED) {
			pos.x += velocity.x * dt;
			pos.y += velocity.y * dt;
		}


		if(direction.length != 0) {
			direction.length = 1;

			accelerate(dt);

			if(direction.x == 0) { decelerate_x(dt); }
			if(direction.y == 0) { decelerate_y(dt); }

			if(is_moving == false) {
				sprite.events.fire('movement.start');
			}

			is_moving = true;
		} else {
			decelerate_x(dt);
			decelerate_y(dt);

			if(is_moving == true) {
				sprite.events.fire('movement.stop');
			}

			is_moving = false;
		}
	} // update

	function accelerate(dt:Float) {

		velocity.x += direction.x * (max_move_speed / acceleration_time) * dt;
		velocity.y += direction.y * (max_move_speed / acceleration_time) * dt;

		if(velocity.length > max_move_speed) {
			velocity.length = max_move_speed;
		}

	} // accelerate

	function decelerate_x(dt:Float) {
		velocity.x = Math.max(velocity.x - (max_move_speed / deceleration_time) * dt, 0);
	} // decelerate_x

	function decelerate_y(dt:Float) {
		velocity.y = Math.max(velocity.y - (max_move_speed / deceleration_time) * dt, 0);
		// velocity.length = Math.max(velocity.length - (max_move_speed / deceleration_time) * dt, 0);
	} // decelerate_y

	function knockback(e) {
		// DO SOMETHING!?!
	}

}
