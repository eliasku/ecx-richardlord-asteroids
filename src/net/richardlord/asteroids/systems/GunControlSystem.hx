package net.richardlord.asteroids.systems;

import ecx.Family;
import ecx.System;
import ecx.Wire;
import ecx.common.systems.TimeSystem;
import net.richardlord.asteroids.EntityCreator;
import net.richardlord.asteroids.components.Gun;
import net.richardlord.asteroids.components.GunControls;
import net.richardlord.asteroids.components.Position;

class GunControlSystem extends System {

	var _entities:Family<GunControls, Gun, Position>;
	var _control:Wire<GunControls>;
	var _gun:Wire<Gun>;
	var _position:Wire<Position>;

	var _keyPoll:Wire<KeyPoll>;
	var _creator:Wire<EntityCreator>;
	var _time:Wire<TimeSystem>;

	public function new() {}

	override function update() {
		var dt = _time.deltaTime;
		for (entity in _entities) {
			var control = _control.get(entity);
			var position = _position.get(entity);
			var gun = _gun.get(entity);
			gun.shooting = _keyPoll.isDown(control.trigger);
			gun.timeSinceLastShot += dt;
			if (gun.shooting && gun.timeSinceLastShot >= gun.minimumShotInterval) {
				_creator.createUserBullet(gun, position);
				gun.timeSinceLastShot = 0;
			}
		}
	}
}
