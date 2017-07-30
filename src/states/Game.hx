package states;

import luxe.States;

import luxe.Vector;
import luxe.Color;
import luxe.Sprite;

import entities.Player;
import entities.Gun;
import entities.World;
import entities.PlayerEnergyBar;

import phoenix.Batcher;

class Game extends State {

	public var player : Player;

	var glow_batcher_fill : Sprite;
	var darkness_over : Sprite;
	var darkness_under : Sprite;

	override public function new() {
		super({
			name: 'Game'
		});
	} // new

	override function onenter<T>(_:T){

		create_glow_batcher();
		create_darkness();
		create_HUD();

		player = new Player();
		C.world = new World();
		new Gun();

	} // onenter

	override function onleave<T>(_:T){

		Luxe.scene.empty();

	} // onleave

	override function update(dt:Float){

		Luxe.camera.center = new Vector(Math.round(player.pos.x), Math.round(player.pos.y));

		glow_batcher_fill.pos = Luxe.camera.center;
		darkness_over.pos = Luxe.camera.center;
		darkness_under.pos = Luxe.camera.center;

	} // update

	function create_glow_batcher() {
		C.glow_batcher = Luxe.renderer.create_batcher({
			name: 'Glow',
			layer: 2,
			camera: Luxe.camera.view
		});

		C.glow_batcher.on(prerender, set_glow_blendmodes);
		C.glow_batcher.on(postrender, unset_glow_blendmodes);

		glow_batcher_fill = new Sprite({
			pos: Luxe.camera.center,
			size: Luxe.screen.size,
			color: new Color().set(0, 0, 0, 1),
			batcher: C.glow_batcher
		});

	} // create_glow_batcher

	function create_darkness() {
		darkness_under = new Sprite({
			pos: Luxe.camera.center,
			size: Luxe.screen.size,
			color: new Color().set(0, 0, 0, 0.1),
			depth: 2,
		});

		darkness_over = new Sprite({
			pos: Luxe.camera.center,
			size: Luxe.screen.size,
			color: new Color().set(0, 0, 0, 0.2),
			depth: 20,
		});
	} // create_darkness

	function create_HUD() {

		C.HUD = Luxe.renderer.create_batcher({
			name: 'HUD',
			layer: 3
		});

		new PlayerEnergyBar();

	} // create_HUD

	function set_glow_blendmodes(b:Batcher) {

		Luxe.renderer.blend_mode(
	        BlendMode.dst_color, 
	        BlendMode.dst_alpha
	    );

	    Luxe.renderer.blend_equation(BlendEquation.add);

	} // set_glow_blendmodes

	function unset_glow_blendmodes(b:Batcher) {

		Luxe.renderer.blend_mode();

		Luxe.renderer.blend_equation();

	} // unset_glow_blendmodes

} // Game
