package net.richardlord.asteroids.core;

import ecx.Service;
import ecx.Wire;
import ecx.common.systems.SystemRunner;
import flash.Lib;
import flash.events.Event;

class EnterFrameService extends Service {

	var _runner:Wire<SystemRunner>;

	public function new() {}

	override function initialize() {
		Lib.current.stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);
	}

	function onEnterFrame(_) {
		_runner.updateFrame();
	}
}
