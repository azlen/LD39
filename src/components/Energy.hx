package components;

import luxe.Component;

class Energy extends Component {

	public var value : Int;
	public var max_value : Int;

	override public function new(v:Int) {

		super({
			name: 'Energy',
		});

		value = v;
		max_value = v;

	} // new

	override public function init() {

		entity.events.listen('damage', damage);
		entity.events.listen('heal', heal);

	} // init

	override function update(dt:Float) {



	} // update

	function damage(e) {
		
		value -= e.amount;

		if(value <= 0) {
			entity.events.fire('die');
		}

	} // hurt

	function heal(e) {

		value += e.amount;

		if(value > max_value) {
			value = max_value;
		}

	}

}