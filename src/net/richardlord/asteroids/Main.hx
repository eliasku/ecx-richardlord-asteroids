package net.richardlord.asteroids;

import flash.display.Sprite;
import ecx.Engine;
import ecx.WorldConfig;
import ecx.World;

import net.richardlord.asteroids.core.FsmSystem;
import net.richardlord.asteroids.systems.RenderSystem;
import net.richardlord.asteroids.systems.AnimationSystem;
import net.richardlord.asteroids.systems.CollisionSystem;
import net.richardlord.asteroids.systems.MovementSystem;
import net.richardlord.asteroids.systems.DeathThroesSystem;
import net.richardlord.asteroids.systems.BulletAgeSystem;
import net.richardlord.asteroids.systems.GunControlSystem;
import net.richardlord.asteroids.systems.MotionControlSystem;
import net.richardlord.asteroids.systems.GameManager;
import net.richardlord.asteroids.core.FpsMeter;
import net.richardlord.asteroids.core.Stats;
import net.richardlord.asteroids.core.TimeSystem;
import net.richardlord.asteroids.core.UpdateSystem;

class Main extends Sprite {

	var _world:World;

	public function new() {
		super();

		var config = new WorldConfig();

		// Priorities:
		var preUpdate:Int = 1;
		var update:Int = 2;
		var move:Int = 3;
		var resolveCollisions:Int = 4;
		var stateMachines:Int = 5;
		var animate:Int = 6;
		var render:Int = 7;

		// ecx-specific boilerplate
		config.add(new UpdateSystem());
		config.add(new TimeSystem(), -1000);

		// just stats example
		config.add(new Stats());
		config.add(new FpsMeter());

		// simple FSM
//		config.add(new FsmSystem());

		// asteroids globals became injectable systems
		config.add(new KeyPoll());
		config.add(new GameConfig());
		config.add(new EntityCreator());

		// asteroids
		config.add(new GameManager(), preUpdate);
		config.add(new FsmSystem(), update);
		config.add(new MotionControlSystem(), update);
		config.add(new GunControlSystem(), update);
		config.add(new BulletAgeSystem(), update);
		config.add(new DeathThroesSystem(), update);
		config.add(new MovementSystem(), move);
		config.add(new CollisionSystem(), resolveCollisions);
		config.add(new AnimationSystem(), animate);
		config.add(new RenderSystem(), render);

		// create world
		_world = Engine.initialize().createWorld(config, 1000);
	}
}
