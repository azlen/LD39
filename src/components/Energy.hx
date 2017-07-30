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

		entity.events.listen('damage', hurt);
		
	} // init

	override function update(dt:Float) {



	} // update

	function hurt(e) {

		value -= 1;

		if(value <= 0) {
			entity.events.fire('die');
		}

	} // hurt

}