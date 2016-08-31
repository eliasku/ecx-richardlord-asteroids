package net.richardlord.asteroids.systems;

import ecx.Family;
import net.richardlord.asteroids.components.Age;
import ecx.Wire;
import net.richardlord.asteroids.core.TimeSystem;
import ecx.System;

class AgeSystem extends System {

	var _time:Wire<TimeSystem>;
	var _age:Wire<Age>;

	var _entities:Family<Age>;

	public function new() {}

	override function update() {
		var dt = _time.deltaTime;
		for(entity in _entities) {
			var age = _age.get(entity);
			age.lifeRemaining -= dt;
			if (age.lifeRemaining <= 0) {
				world.delete(entity);
			}
		}
	}
}
