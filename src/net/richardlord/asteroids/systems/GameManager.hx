package net.richardlord.asteroids.systems;

import flash.geom.Point;
import ecx.Family;
import ecx.Wire;
import ecx.System;
import net.richardlord.asteroids.core.TimeSystem;
import net.richardlord.asteroids.components.Bullet;
import net.richardlord.asteroids.components.Asteroid;
import net.richardlord.asteroids.components.Collision;
import net.richardlord.asteroids.components.Position;
import net.richardlord.asteroids.components.Spaceship;
import net.richardlord.asteroids.components.GameState;
import net.richardlord.asteroids.EntityCreator;
import net.richardlord.asteroids.GameConfig;

class GameManager extends System {

	var _config:Wire<GameConfig>;
	var _creator:Wire<EntityCreator>;
	var _time:Wire<TimeSystem>;

	var _gameStates:Family<GameState>;
	var _gameState:Wire<GameState>;

	var _spaceships:Family<Spaceship, Position>;
	var _spaceship:Wire<Spaceship>;
	var _position:Wire<Position>;

	var _asteroids:Family<Asteroid, Position, Collision>;
	var _asteroid:Wire<Asteroid>;
	var _collision:Wire<Collision>;

	var _bullets:Family<Bullet, Position, Collision>;
	var _bullet:Wire<Bullet>;

	public function new() {}

	override function update() {
		if (_gameStates.length == 0) {
			_creator.createGame();
			return;
		}

		var dt = _time.deltaTime;
		for (gameStateEntity in _gameStates) {
			var gameState = _gameState.get(gameStateEntity);
			if (_spaceships.length == 0) {
				if (gameState.lives > 0) {
					var newSpaceshipPosition = new Point(_config.width * 0.5, _config.height * 0.5);
					var clearToAddSpaceship = true;

					for (asteroidEntity in _asteroids) {
						var asteroidPosition = _position.get(asteroidEntity);
						var asteroidCollisition = _collision.get(asteroidEntity);
						if (Point.distance(asteroidPosition.position, newSpaceshipPosition) <= asteroidCollisition.radius + 50) {
							clearToAddSpaceship = false;
							break;
						}
					}
					if (clearToAddSpaceship) {
						_creator.createSpaceship();
						gameState.lives--;
					}
				}
				else {
					// game over
				}
			}

			if (_asteroids.length == 0 && _bullets.length == 0 && _spaceships.length > 0) {
				// next level
				var spaceshipEntity = _spaceships.get(0);
				var spaceship = _spaceship.get(spaceshipEntity);
				var spaceshipPosition = _position.get(spaceshipEntity);
				gameState.level++;
				var asteroidCount:Int = 2 + gameState.level;
				for (i in 0...asteroidCount) {
					// check not on top of spaceship
					var position:Point;
					do {
						position = new Point(Math.random() * _config.width, Math.random() * _config.height);
					}
					while (Point.distance(position, spaceshipPosition.position) <= 80);
					_creator.createAsteroid(30, position.x, position.y);
				}
			}
		}
	}
}
