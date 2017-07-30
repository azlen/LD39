
import luxe.Input;
import luxe.Vector;
import luxe.Color;
import luxe.Sprite;

import entities.Player;
import entities.Gun;
import entities.World;

import entities.PlayerEnergyBar;

import phoenix.Batcher;

import luxe.resource.Resource;

import C;

#if (!web)
	import luxe.gifcapture.LuxeGifCapture;
	import dialogs.Dialogs; // dialogs for saving gifs
#end

class Main extends luxe.Game {

	#if (!web)
		var capture : LuxeGifCapture;
	#end

	public var player : Player;

	var glow_batcher_fill : Sprite;
	var darkness_over : Sprite;
	var darkness_under : Sprite;

	var music : AudioResource;

	override function ready() {

		music = Luxe.resources.audio('assets/music/music.wav');
		Luxe.audio.loop(music.source);

		Luxe.renderer.clear_color = new Color().rgb(0x000000);

		create_glow_batcher();
		create_darkness();
		create_HUD();

		player = new Player();

		C.world = new World();
		
		new Gun();

		connect_input();
		
		#if (!web)
			init_gifcapture();
		#end
		
	} // ready

	override function onkeyup( e:KeyEvent ) {

		#if (!web)
			if(e.keycode == Key.space) {
				if(capture.state == Paused) {
					capture.record();
					trace('recording: active');
				} else if (capture.state == Recording) {
					capture.commit();
					trace('recording: committed');
				}
			}
		#end

		if(e.keycode == Key.escape) {
			Luxe.shutdown();
		}

	} // onkeyup

	override function update(dt:Float) {

		Luxe.camera.center = new Vector(Math.round(player.pos.x), Math.round(player.pos.y));

		glow_batcher_fill.pos = Luxe.camera.center;
		darkness_over.pos = Luxe.camera.center;
		darkness_under.pos = Luxe.camera.center;

	} // update

	function connect_input() {

		// WASD controls

		Luxe.input.bind_key('up', Key.key_w);
		Luxe.input.bind_key('left', Key.key_a);
		Luxe.input.bind_key('down', Key.key_s);
		Luxe.input.bind_key('right', Key.key_d);

	} // connect_input

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

	#if (!web)
		function init_gifcapture() {

			capture = new LuxeGifCapture({
				width: Std.int(Luxe.screen.w/2),
				height: Std.int(Luxe.screen.h/2),
				fps: 30, 
				max_time: 10,
				quality: GifQuality.Worst,
				repeat: GifRepeat.Infinite,
				oncomplete: function(_bytes:haxe.io.Bytes) {
					var path = Dialogs.save('Save GIF');
					if(path != '') sys.io.File.saveBytes(path, _bytes);
				}
			});

		} // init_gifcapture
	#end

	override function config(config:luxe.GameConfig) {

		config.preload.textures.push({ id: 'assets/images/player_animation.png' });
		config.preload.textures.push({ id: 'assets/images/red_led_enemy.png' });
		config.preload.jsons.push({ id: 'assets/animations/player_animation.json' });

		config.preload.textures.push({ id: 'assets/images/dungeon.png' });
		config.preload.textures.push({ id: 'assets/images/gun.png' });
		config.preload.textures.push({ id: 'assets/images/bullet.png' });
		config.preload.textures.push({ id: 'assets/images/glow.png' });
		config.preload.textures.push({ id: 'assets/images/glow_alpha.png' });
		config.preload.textures.push({ id: 'assets/images/battery.png' });

		config.preload.sounds.push({ id: 'assets/sounds/hurt.wav', is_stream: false });
		config.preload.sounds.push({ id: 'assets/sounds/pickup.wav', is_stream: false });
		config.preload.sounds.push({ id: 'assets/sounds/shoot.wav', is_stream: false });

		config.preload.sounds.push({ id: 'assets/music/music.wav', is_stream: false });

		return config;

	} //config


} //Main
