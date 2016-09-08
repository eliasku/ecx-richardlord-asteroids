package net.richardlord.asteroids;

import ecx.Entity;
import ecx.Service;
import ecx.Wire;
import ecx.World;
import ecx.common.components.Fsm;
import flash.ui.Keyboard;
import net.richardlord.asteroids.components.Age;
import net.richardlord.asteroids.components.Animation;
import net.richardlord.asteroids.components.Asteroid;
import net.richardlord.asteroids.components.Bullet;
import net.richardlord.asteroids.components.Collision;
import net.richardlord.asteroids.components.Display;
import net.richardlord.asteroids.components.GameState;
import net.richardlord.asteroids.components.Gun;
import net.richardlord.asteroids.components.GunControls;
import net.richardlord.asteroids.components.Motion;
import net.richardlord.asteroids.components.MotionControls;
import net.richardlord.asteroids.components.Position;
import net.richardlord.asteroids.components.Spaceship;
import net.richardlord.asteroids.graphics.AsteroidView;
import net.richardlord.asteroids.graphics.BulletView;
import net.richardlord.asteroids.graphics.SpaceshipDeathView;
import net.richardlord.asteroids.graphics.SpaceshipView;

class EntityCreator extends Service {

	var _gameState:Wire<GameState>;
	var _asteroid:Wire<Asteroid>;
	var _position:Wire<Position>;
	var _collision:Wire<Collision>;
	var _motion:Wire<Motion>;
	var _display:Wire<Display>;
	var _fsm:Wire<Fsm>;
	var _spaceship:Wire<Spaceship>;
	var _motionControls:Wire<MotionControls>;
	var _gun:Wire<Gun>;
	var _gunControls:Wire<GunControls>;
	var _animation:Wire<Animation>;
	var _age:Wire<Age>;
	var _bullet:Wire<Bullet>;

	public function new() {}

	public function createGame():Entity {
		var entity = world.create();
		_gameState.create(entity);

		world.commit(entity);
		return entity;
	}

	public function createAsteroid(radius:Float, x:Float, y:Float):Entity {
		var entity = world.create();
		_asteroid.create(entity);
		var position = _position.create(entity);
		var collision = _collision.create(entity);
		var motion = _motion.create(entity);
		var sprite = _display.create(entity);
		position.setup(x, y, 0);
		collision.radius = radius;
		motion.setup((Math.random() - 0.5) * 4 * (50 - radius), (Math.random() - 0.5) * 4 * (50 - radius), Math.random() * 2 - 1, 0);
		sprite.addChild(new AsteroidView(radius));

		world.commit(entity);
		return entity;
	}

	public function createSpaceship():Entity {
		var entity = world.create();
		var fsm = _fsm.create(entity);
		var position = _position.create(entity);
		var sprite = _display.create(entity);

		fsm.addState("playing", function(world:World, entity:Entity) {
			_spaceship.create(entity);
			_motion.create(entity).setup(0, 0, 0, 15);
			_motionControls.create(entity).setup(Keyboard.LEFT, Keyboard.RIGHT, Keyboard.UP, 100, 3);
			_gun.create(entity).setup(8, 0, 0.08, 2, 10);
			_gunControls.create(entity).trigger = Keyboard.SPACE;
			_collision.create(entity).radius = 9;
			_display.get(entity).addChild(new SpaceshipView());
		},
		function(world:World, entity:Entity) {
			_spaceship.destroy(entity);
			_motion.destroy(entity);
			_motionControls.destroy(entity);
			_gun.destroy(entity);
			_gunControls.destroy(entity);
			_collision.destroy(entity);
			_display.get(entity).removeChildren();
		});

		fsm.addState("destroyed", function(world:World, entity:Entity) {
			var deathAnimation = new SpaceshipDeathView();
			_age.create(entity).lifeRemaining = 5;
			_animation.set(entity, deathAnimation);
			_display.get(entity).addChild(deathAnimation);
		},
		function(world:World, entity:Entity) {
			_age.destroy(entity);
			_animation.destroy(entity);
			_display.get(entity).removeChildren();
		});

		position.setup(300, 225, 0);

		fsm.setState("playing");

		world.commit(entity);
		return entity;
	}

	public function createUserBullet(gun:GunData, parentPosition:PositionData):Entity {
		var rotation = parentPosition.rotation + gun.spreadAngle * (Math.random() - 0.5) * Math.PI / 180;
		var cos = Math.cos(rotation);
		var sin = Math.sin(rotation);
		var velocity = 300;

		var entity = world.create();
		_bullet.create(entity);
		var position = _position.create(entity);
		var collision = _collision.create(entity);
		var motion = _motion.create(entity);
		var sprite = _display.create(entity);

		_age.create(entity).lifeRemaining = gun.bulletLifetime;
		position.setup(cos * gun.offsetFromParent.x - sin * gun.offsetFromParent.y + parentPosition.position.x, sin * gun.offsetFromParent.x + cos * gun.offsetFromParent.y + parentPosition.position.y, 0);
		collision.radius = 0;
		motion.setup(cos * velocity, sin * velocity, 0, 0);
		sprite.addChild(new BulletView());

		world.commit(entity);
		return entity;
	}
}
