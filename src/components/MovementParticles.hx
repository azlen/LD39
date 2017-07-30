package components;

import luxe.Component;

import luxe.Particles.ParticleSystem;
import luxe.Particles.ParticleEmitter;
import luxe.options.ParticleOptions.ParticleEmitterOptions;

import luxe.Vector;
import luxe.Color;

import luxe.Sprite;

class MovementParticles extends Component {

	var sprite : Sprite;

	var emitter : ParticleEmitter;
	var particles : ParticleSystem;

	override public function new() {

		super({
			name: 'MovementParticles',
		});

	} // new

	override function init() {
		sprite = cast entity;

		particles = new ParticleSystem();

		particles.parent = sprite;

		var options : ParticleEmitterOptions = {
			name: 'dustParticles',
			// group: 5,
			emit_time: 0.5,
			emit_count: 5,
			direction: 0,
			direction_random: 0,
			speed: 0,
			speed_random: 0,
			end_speed: 0,
			life: 0.5,
			life_random: 0.15,
			rotation: 0,
			rotation_random: 25,
			end_rotation: 0,
			end_rotation_random: 20,
			rotation_offset: 0,
			pos_offset: new Vector(0, 0),
			pos_random: new Vector(8, 5),
			gravity: new Vector(0, -90),
			start_size: new Vector(10, 10),
			start_size_random: new Vector(0, 0),
			end_size: new Vector(0, 0),
			end_size_random: new Vector(0, 0),
			start_color: new ColorHSV(0, 0, 1, 1),
			end_color: new ColorHSV(0, 0, 0.5, 1)
		};

		particles.add_emitter(options);
		emitter = particles.get('dustParticles');

		emitter.init();
		emitter.stop();

		sprite.events.listen('movement.start', resume_particles);
		sprite.events.listen('movement.stop', pause_particles);

	}

	override function update(dt:Float) {
		particles.pos = sprite.pos.clone().add(new Vector(0, sprite.size.y/2));
	}

	function pause_particles(e) {
		emitter.stop();
	}

	function resume_particles(e) {
		emitter.start();
	}

}
