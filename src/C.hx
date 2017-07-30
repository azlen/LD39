package;

import phoenix.Batcher;
import entities.World;
import entities.Enemy;

class C {

	public static var glow_batcher : Batcher;
	public static var HUD : Batcher;

	public static var floor_tiles : Array<Int> = [ 3 ];
	public static var world : World;

	public static var enemies_alive : Array<Enemy> = [];

	static var increment : Int = 0;
	public static function unique_id() {
		return increment++;
	}

	/*public static var enemy_types : Map = [
		'red_led' => 
	];*/

}