
import luxe.Input;
import luxe.Vector;

import entities.Player;

#if (!web)
	import luxe.gifcapture.LuxeGifCapture;
	import dialogs.Dialogs; // dialogs for saving gifs
#end

class Main extends luxe.Game {

	#if (!web)
		var capture : LuxeGifCapture;
	#end

	var player : Player;

	override function ready() {

		player = new Player();

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

		// Luxe.camera.center = new Vector(Math.round(player.pos.x), Math.round(player.pos.y));

	} // update

	function connect_input() {

		// WASD controls

		Luxe.input.bind_key('up', Key.key_w);
		Luxe.input.bind_key('left', Key.key_a);
		Luxe.input.bind_key('down', Key.key_s);
		Luxe.input.bind_key('right', Key.key_d);

	} // connect_input

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

		return config;

	} //config


} //Main
