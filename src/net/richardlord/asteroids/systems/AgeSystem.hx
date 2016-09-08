package net.richardlord.asteroids.systems;

import ecx.Family;
import ecx.System;
import ecx.Wire;
import ecx.common.systems.TimeSystem;
import net.richardlord.asteroids.components.Age;

class AgeSystem extends System {

	var _time:Wire<TimeSystem>;
	var _age:Wire<Age>;

	var _entities:Family<Age>;

	public function new() {}

	override function update() {
		var dt = _time.deltaTime;
		for (entity in _entities) {
			var age = _age.get(entity);
			age.lifeRemaining -= dt;
			if (age.lifeRemaining <= 0) {
				world.destroy(entity);
			}
		}
	}
}
