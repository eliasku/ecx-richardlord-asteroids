package net.richardlord.asteroids.core;

import haxe.Timer;
import ecx.System;

class TimeSystem extends System {

	public var deltaTime(default, null):Float = 0.01;

	var _lastTime:Float = 0;

	public function new() {}

	override function initialize() {
		_lastTime = Timer.stamp();
	}

	override function update() {
		var now = Timer.stamp();
		deltaTime = now - _lastTime;
		_lastTime = now;
	}
}
