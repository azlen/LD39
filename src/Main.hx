
import luxe.Input;
import luxe.Color;

import luxe.resource.Resource;

import luxe.States;
import states.*;

import luxe.Parcel;
import luxe.ParcelProgress;

import C;

/*
#if (!web)
	import luxe.gifcapture.LuxeGifCapture;
	import dialogs.Dialogs; // dialogs for saving gifs
#end
*/

class Main extends luxe.Game {

	/*
	#if (!web)
		var capture : LuxeGifCapture;
	#end
	*/

	var music : AudioResource;

	override function ready() {
		preload_assets();

		/*
		#if (!web)
			init_gifcapture();
		#end
		*/
	} // ready

	function assets_loaded(_) {

		init_states();

		music = Luxe.resources.audio('assets/music/music.wav');
		Luxe.audio.loop(music.source);

		Luxe.renderer.clear_color = new Color().rgb(0x000000);


		connect_input();
	} // assets_loaded

	function init_states() {

		C.state = new States({ name: 'StateMachine' });

		C.state.add(new Menu());
		C.state.add(new Game());
		C.state.add(new Lose());
		C.state.add(new Win());

		C.state.set('Menu');

	} // init_states

	override function onkeyup( e:KeyEvent ) {

		/*
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
		*/

		if(e.keycode == Key.escape) {
			Luxe.shutdown();
		}

	} // onkeyup

	function connect_input() {

		// WASD controls

		Luxe.input.bind_key('up', Key.key_w);
		Luxe.input.bind_key('left', Key.key_a);
		Luxe.input.bind_key('down', Key.key_s);
		Luxe.input.bind_key('right', Key.key_d);

	} // connect_input

	/*
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
	*/

	function preload_assets() {

		var parcel = new Parcel({
			textures : [
				{ id:'assets/images/player_animation.png' },
				{ id:'assets/images/red_led_enemy.png' },
				{ id:'assets/images/dungeon.png' },
				{ id:'assets/images/gun.png' },
				{ id:'assets/images/bullet.png' },
				{ id:'assets/images/glow.png' },
				{ id:'assets/images/glow_alpha.png' },
				{ id:'assets/images/battery.png' },
				{ id:'assets/images/battery_powerup.png' },
				{ id:'assets/images/title_screen.png' },
				{ id:'assets/images/press_any_key.png' },
			],
			jsons: [
				{ id:'assets/animations/player_animation.json' },
			],
			sounds: [
				{ id: 'assets/sounds/hurt.wav', is_stream: false },
				{ id: 'assets/sounds/pickup.wav', is_stream: false },
				{ id: 'assets/sounds/shoot.wav', is_stream: false },

				{ id: 'assets/music/music.wav', is_stream: false },
			]
		});

		new ParcelProgress({
			parcel      : parcel,
			background  : new Color(0,0,0,0.85),
			oncomplete  : assets_loaded,
		});

			//go!
		parcel.load();
	}

	override function config(config:luxe.GameConfig) {

		/*config.preload.textures.push({ id: 'assets/images/player_animation.png' });
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

		config.preload.sounds.push({ id: 'assets/music/music.wav', is_stream: false });*/



		return config;

	} //config


} //Main
