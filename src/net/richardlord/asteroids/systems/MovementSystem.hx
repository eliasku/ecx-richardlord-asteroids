package net.richardlord.asteroids.systems;

import ecx.Family;
import ecx.System;
import ecx.Wire;
import ecx.common.systems.TimeSystem;
import net.richardlord.asteroids.GameConfig;
import net.richardlord.asteroids.components.Motion;
import net.richardlord.asteroids.components.Position;

class MovementSystem extends System {

	var _entities:Family<Position, Motion>;
	var _position:Wire<Position>;
	var _motion:Wire<Motion>;

	var _config:Wire<GameConfig>;
	var _time:Wire<TimeSystem>;

	public function new() {}

	override function update() {
		var dt = _time.deltaTime;
		var width = _config.width;
		var height = _config.height;

		for (entity in _entities) {
			var position = _position.get(entity);
			var motion = _motion.get(entity);

			position.position.x += motion.velocity.x * dt;
			position.position.y += motion.velocity.y * dt;

			if (position.position.x < 0) {
				position.position.x += width;
			}
			if (position.position.x > width) {
				position.position.x -= width;
			}
			if (position.position.y < 0) {
				position.position.y += height;
			}
			if (position.position.y > height) {
				position.position.y -= height;
			}
			position.rotation += motion.angularVelocity * dt;
			if (motion.damping > 0) {
				var xDamp:Float = Math.abs(Math.cos(position.rotation) * motion.damping * dt);
				var yDamp:Float = Math.abs(Math.sin(position.rotation) * motion.damping * dt);
				if (motion.velocity.x > xDamp) {
					motion.velocity.x -= xDamp;
				}
				else if (motion.velocity.x < -xDamp) {
					motion.velocity.x += xDamp;
				}
				else {
					motion.velocity.x = 0;
				}
				if (motion.velocity.y > yDamp) {
					motion.velocity.y -= yDamp;
				}
				else if (motion.velocity.y < -yDamp) {
					motion.velocity.y += yDamp;
				}
				else {
					motion.velocity.y = 0;
				}
			}
		}
	}
}
