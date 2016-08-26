package net.richardlord.asteroids.systems;

import ecx.Family;
import ecx.Wire;
import ecx.System;
import net.richardlord.asteroids.core.TimeSystem;
import net.richardlord.asteroids.components.Motion;
import net.richardlord.asteroids.components.MotionControls;
import net.richardlord.asteroids.components.Position;

class MotionControlSystem extends System {

	var _entities:Family<MotionControls, Position, Motion>;
	var _control:Wire<MotionControls>;
	var _position:Wire<Position>;
	var _motion:Wire<Motion>;

	var _keyPoll:Wire<KeyPoll>;
	var _time:Wire<TimeSystem>;

	public function new() {}

	override function update() {
		var dt = _time.deltaTime;
		for(entity in _entities) {
			var control = _control.get(entity);
			var position = _position.get(entity);
			var motion = _motion.get(entity);

			if (_keyPoll.isDown(control.left)) {
				position.rotation -= control.rotationRate * dt;
			}

			if (_keyPoll.isDown(control.right)) {
				position.rotation += control.rotationRate * dt;
			}

			if (_keyPoll.isDown(control.accelerate)) {
				motion.velocity.x += Math.cos(position.rotation) * control.accelerationRate * dt;
				motion.velocity.y += Math.sin(position.rotation) * control.accelerationRate * dt;
			}
		}
	}
}