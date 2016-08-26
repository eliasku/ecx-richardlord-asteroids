package net.richardlord.asteroids.systems;

import flash.geom.Point;
import ecx.Family;
import ecx.Wire;
import ecx.System;
import net.richardlord.asteroids.core.Fsm;
import net.richardlord.asteroids.components.Collision;
import net.richardlord.asteroids.components.Position;
import net.richardlord.asteroids.components.Bullet;
import net.richardlord.asteroids.components.Asteroid;
import net.richardlord.asteroids.components.Spaceship;
import net.richardlord.asteroids.EntityCreator;

class CollisionSystem extends System {

	var _creator:Wire<EntityCreator>;

	var _spaceship:Wire<Spaceship>;
	var _fsm:Wire<Fsm>;
	var _asteroid:Wire<Asteroid>;
	var _bullet:Wire<Bullet>;
	var _position:Wire<Position>;
	var _collision:Wire<Collision>;

	var _spaceships:Family<Spaceship, Position, Collision>;
	var _asteroids:Family<Asteroid, Position, Collision>;
	var _bullets:Family<Bullet, Position, Collision>;

	public function new() {}

	override function update() {
		for (bulletEntity in _bullets) {
			var bulletPosition = _position.get(bulletEntity);

			for (asteroidEntity in _asteroids) {
				var asteroidPosition = _position.get(asteroidEntity);
				var asteroidCollision = _collision.get(asteroidEntity);

				if (Point.distance(asteroidPosition.position, bulletPosition.position) <= asteroidCollision.radius) {
					world.delete(bulletEntity);
					if (asteroidCollision.radius > 10) {
						_creator.createAsteroid(asteroidCollision.radius - 10, asteroidPosition.position.x + Math.random() * 10 - 5, asteroidPosition.position.y + Math.random() * 10 - 5);
						_creator.createAsteroid(asteroidCollision.radius - 10, asteroidPosition.position.x + Math.random() * 10 - 5, asteroidPosition.position.y + Math.random() * 10 - 5);
					}
					world.delete(asteroidEntity);
					break;
				}
			}
		}

		for (spaceshipEntity in _spaceships) {
			var spaceshipPosition = _position.get(spaceshipEntity);
			var spaceshipCollision = _collision.get(spaceshipEntity);

			for (asteroidEntity in _asteroids) {
				var asteroidPosition = _position.get(asteroidEntity);
				var asteroidCollision = _collision.get(asteroidEntity);

				if (Point.distance(asteroidPosition.position, spaceshipPosition.position) <= asteroidCollision.radius + spaceshipCollision.radius) {
					_fsm.get(spaceshipEntity).setState("destroyed");
					break;
				}
			}
		}
	}
}
