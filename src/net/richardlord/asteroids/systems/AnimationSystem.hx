package net.richardlord.asteroids.systems;

import ecx.Wire;
import ecx.System;
import ecx.Family;
import ecx.MapTo;
import net.richardlord.asteroids.core.TimeSystem;
import net.richardlord.asteroids.components.Animation;

class AnimationSystem extends System {

	var _entities:Family<Animation>;
	var _animation:MapTo<Animation>;

	var _time:Wire<TimeSystem>;

	public function new() {}

	override function update() {
		var dt = _time.deltaTime;
		for(entity in _entities) {
			var animation = _animation.get(entity);
			animation.animation.animate(dt);
		}
	}
}
