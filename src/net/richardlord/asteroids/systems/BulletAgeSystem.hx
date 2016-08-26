package net.richardlord.asteroids.systems;

import ecx.Family;
import ecx.Wire;
import ecx.System;
import net.richardlord.asteroids.core.TimeSystem;
import net.richardlord.asteroids.components.Bullet;

class BulletAgeSystem extends System {

	var _time:Wire<TimeSystem>;
	var _bullet:Wire<Bullet>;

	var _entities:Family<Bullet>;

	public function new() {}

	override function update() {
		var dt = _time.deltaTime;
		for(entity in _entities) {
			var bullet = _bullet.get(entity);
			bullet.lifeRemaining -= dt;
			if (bullet.lifeRemaining <= 0) {
				world.delete(entity);
			}
		}
	}
}
