package net.richardlord.asteroids;

import ecx.Engine;
import ecx.World;
import ecx.WorldConfig;
import ecx.common.EcxCommon;
import flash.display.Sprite;
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
import net.richardlord.asteroids.core.EnterFrameService;
import net.richardlord.asteroids.core.StatsView;
import net.richardlord.asteroids.systems.AgeSystem;
import net.richardlord.asteroids.systems.AnimationSystem;
import net.richardlord.asteroids.systems.CollisionSystem;
import net.richardlord.asteroids.systems.GameManager;
import net.richardlord.asteroids.systems.GunControlSystem;
import net.richardlord.asteroids.systems.MotionControlSystem;
import net.richardlord.asteroids.systems.MovementSystem;
import net.richardlord.asteroids.systems.RenderSystem;

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

		config.include(new EcxCommon());

		// just stats example
		config.add(new StatsView());
		config.add(new EnterFrameService());

		// asteroid's static classes became injectable services
		config.add(new KeyPoll());
		config.add(new GameConfig());
		config.add(new EntityCreator());

		// asteroids
		config.add(new GameManager(), preUpdate);
		config.add(new MotionControlSystem(), update);
		config.add(new GunControlSystem(), update);
		config.add(new AgeSystem(), update);
		config.add(new MovementSystem(), move);
		config.add(new CollisionSystem(), resolveCollisions);
		config.add(new AnimationSystem(), animate);
		config.add(new RenderSystem(), render);

		// components
		config.add(new Animation());
		config.add(new Asteroid());
		config.add(new Bullet());
		config.add(new Collision());
		config.add(new Age());
		config.add(new Display());
		config.add(new GameState());
		config.add(new Gun());
		config.add(new GunControls());
		config.add(new Motion());
		config.add(new MotionControls());
		config.add(new Position());
		config.add(new Spaceship());

		// create world
		_world = Engine.createWorld(config, 1000);
	}
}
