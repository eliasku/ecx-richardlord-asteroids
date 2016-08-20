package net.richardlord.asteroids.core;

import flash.Lib;
import flash.text.TextField;
import ecx.System;
import ecx.Wire;

class Stats extends System {

	var _fpsMeter:Wire<FpsMeter>;
	var _time:Wire<TimeSystem>;

	var _tf:TextField;

	public function new() {}

	override function initialize() {
		_tf = new TextField();
		_tf.textColor = 0xFFFFFF;
		Lib.current.stage.addChild(_tf);
	}

	override function update() {
		var lines = [
			"FPS: " + _fpsMeter.fps,
			"dt: " + _time.deltaTime
		];
		_tf.text = lines.join("\n");
	}
}
