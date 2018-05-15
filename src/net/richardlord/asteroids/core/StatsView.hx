package net.richardlord.asteroids.core;

import flash.ui.Keyboard;
import ecx.System;
import ecx.Wire;
import ecx.common.systems.FpsMeter;
import ecx.common.systems.SystemRunner;
import ecx.common.systems.TimeSystem;
import flash.Lib;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;

class StatsView extends System {

	var _fpsMeter:Wire<FpsMeter>;
	var _time:Wire<TimeSystem>;
	var _runner:Wire<SystemRunner>;
	var _keys:Wire<KeyPoll>;

	var _tf:TextField;
	var _prevKeyDown:Bool = false;

	public function new() {}

	override function initialize() {
		_tf = new TextField();
		_tf.textColor = 0xFFFFFF;
		_tf.autoSize = TextFieldAutoSize.LEFT;
		Lib.current.stage.addChild(_tf);
	}

	override function update() {
		var lines = [
			"fps: " + formatD2(_fpsMeter.framesPerSecond),
			"dt: " + formatD2(_time.deltaTime * 1000) + " ms"
		];

		var keyDown = _keys.isDown(Keyboard.F1);
		if(!_prevKeyDown && keyDown) {
			_runner.profile = !_runner.profile;
		}
		_prevKeyDown = keyDown;

		if (_runner.profile) {

			lines.push("");

			for (profile in _runner.profileData) {
				var timing = '${formatD2(profile.updateTime * 1000)} + ${formatD2(profile.invalidateTime * 1000)} ms';
				var timingMax = '${formatD2(profile.updateTimeMax * 1000)} + ${formatD2(profile.invalidateTimeMax * 1000)} ms';
				var entitiesInfo = 'changed max: ${profile.changed}; removed max: ${profile.removed}';
				lines.push('${profile.name} : $timing | max: $timingMax | $entitiesInfo');
			}

			lines.push("");

			for (component in world.components()) {
				if (component != null) {
					var name = Type.getClassName(Type.getClass(component));
					var size = component.getObjectSize();
					lines.push('$name : ${size > 0 ? Std.string(size) : "?"} bytes');
				}
			}
		}

		_tf.text = lines.join("\n");
	}

	function formatD2(f:Float):Float {
		return Std.int(f * 100) / 100;
	}
}
