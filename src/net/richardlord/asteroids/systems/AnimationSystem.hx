package net.richardlord.asteroids.systems;

import ecx.Family;
import ecx.System;
import ecx.Wire;
import ecx.common.systems.TimeSystem;
import net.richardlord.asteroids.components.Animation;

class AnimationSystem extends System {

	var _time:Wire<TimeSystem>;
	var _animation:Wire<Animation>;

	var _entities:Family<Animation>;

	public function new() {}

	override function update() {
		var dt = _time.deltaTime;
		for (entity in _entities) {
			_animation.get(entity).animate(dt);
		}
	}
}
