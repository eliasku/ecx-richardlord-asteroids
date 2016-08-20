package net.richardlord.asteroids.core;

import ecx.System;

class FpsMeter extends System {

	public var fps(default, null):Float = 0;

	var _frames:Int = 0;
	var _lastTime:Float;

	public function new() {}

	override function initialize() {
		_lastTime = haxe.Timer.stamp();
	}

	override function update() {
		var now = haxe.Timer.stamp();
		var delta = now - _lastTime;

		if (delta >= 1.0) {
			fps = _frames;
			_frames = 0;
			_lastTime = now;
		}
		else {
			++_frames;
		}
	}
}
