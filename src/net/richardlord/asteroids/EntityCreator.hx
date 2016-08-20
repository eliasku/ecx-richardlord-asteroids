package net.richardlord.asteroids;

import ecx.EntityView;
import net.richardlord.asteroids.core.Fsm;
import ecx.Entity;
import ecx.System;
import flash.ui.Keyboard;
import net.richardlord.asteroids.components.GameState;
import net.richardlord.asteroids.components.Animation;
import net.richardlord.asteroids.components.DeathThroes;
import net.richardlord.asteroids.components.Collision;
import net.richardlord.asteroids.components.Asteroid;
import net.richardlord.asteroids.components.Bullet;
import net.richardlord.asteroids.components.Display;
import net.richardlord.asteroids.components.Gun;
import net.richardlord.asteroids.components.GunControls;
import net.richardlord.asteroids.components.Motion;
import net.richardlord.asteroids.components.MotionControls;
import net.richardlord.asteroids.components.Position;
import net.richardlord.asteroids.components.Spaceship;
import net.richardlord.asteroids.graphics.AsteroidView;
import net.richardlord.asteroids.graphics.BulletView;
import net.richardlord.asteroids.graphics.SpaceshipView;
import net.richardlord.asteroids.graphics.SpaceshipDeathView;

class EntityCreator extends System {

	public function new() {}

	public function createGame():Entity {
		var gameEntity = world.create();
		world.edit(gameEntity).create(GameState);
		return gameEntity;
	}

	public function createAsteroid(radius:Float, x:Float, y:Float):Entity {
		var data = world.edit(world.create());
		data.create(Asteroid);
		var position:Position = data.create(Position);
		var collision:Collision = data.create(Collision);
		var motion:Motion = data.create(Motion);
		var display:Display = data.create(Display);
		position.setup(x, y, 0);
		collision.radius = radius;
		motion.setup((Math.random() - 0.5) * 4 * (50 - radius), (Math.random() - 0.5) * 4 * (50 - radius), Math.random() * 2 - 1, 0);
		display.sprite.addChild(new AsteroidView(radius));
		return data.entity;
	}

	public function createSpaceship():Entity {
		var data = world.edit(world.create());
		var fsm:Fsm = data.create(Fsm);
		var position:Position = data.create(Position);
		var display:Display = data.create(Display);

		fsm.createState("playing", function(e:EntityView) {
			e.create(Spaceship);
			e.create(Motion).setup(0, 0, 0, 15);
			e.create(MotionControls).setup(Keyboard.LEFT, Keyboard.RIGHT, Keyboard.UP, 100, 3);
			e.create(Gun).setup(8, 0, 0.08, 2, 10);
			e.create(GunControls).trigger = Keyboard.SPACE;
			e.create(Collision).radius = 9;
			display.sprite.addChild(new SpaceshipView());
		},
		function(e:EntityView) {
			e.remove(Spaceship);
			e.remove(Motion);
			e.remove(MotionControls);
			e.remove(Gun);
			e.remove(GunControls);
			e.remove(Collision);
			display.sprite.removeChildren();
		});

		fsm.createState("destroyed", function(e:EntityView) {
			var deathAnimation = new SpaceshipDeathView();
			e.create(DeathThroes).countdown = 5;
			e.create(Animation).animation = deathAnimation;
			display.sprite.addChild(deathAnimation);
		},
		function(e:EntityView) {
			e.remove(DeathThroes);
			e.remove(Animation);
			display.sprite.removeChildren();
		});

		position.setup(300, 225, 0);

		fsm.changeState("playing");

		return data.entity;
	}

	public function createUserBullet(gun:Gun, parentPosition:Position):Entity {
		var rotation = parentPosition.rotation + gun.spreadAngle * (Math.random() - 0.5) * Math.PI / 180;
		var cos = Math.cos(rotation);
		var sin = Math.sin(rotation);
		var velocity = 300;

		var data = world.edit(world.create());
		var bullet:Bullet = data.create(Bullet);
		var position:Position = data.create(Position);
		var collision:Collision = data.create(Collision);
		var motion:Motion = data.create(Motion);
		var display:Display = data.create(Display);

		bullet.lifeRemaining = gun.bulletLifetime;
		position.setup(cos * gun.offsetFromParent.x - sin * gun.offsetFromParent.y + parentPosition.position.x, sin * gun.offsetFromParent.x + cos * gun.offsetFromParent.y + parentPosition.position.y, 0);
		collision.radius = 0;
		motion.setup(cos * velocity, sin * velocity, 0, 0);
		display.sprite.addChild(new BulletView());

		return data.entity;
	}
}
