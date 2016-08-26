package net.richardlord.asteroids.systems;

import ecx.Family;
import ecx.Wire;
import ecx.System;
import net.richardlord.asteroids.core.TimeSystem;
import net.richardlord.asteroids.EntityCreator;
import net.richardlord.asteroids.components.DeathThroes;

class DeathThroesSystem extends System {

	var _entities:Family<DeathThroes>;

	var _creator:Wire<EntityCreator>;

	var _death:Wire<DeathThroes>;
	var _time:Wire<TimeSystem>;

	public function new() {}

	override function update() {
		var time = _time.deltaTime;
		for(entity in _entities) {
			var death = _death.get(entity);
			death.countdown -= time;
			if(death.countdown <= 0) {
				world.delete(entity);
			}
		}
	}
}
