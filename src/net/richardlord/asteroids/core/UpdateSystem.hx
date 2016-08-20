package net.richardlord.asteroids.core;

import flash.events.Event;
import flash.Lib;
import ecx.System;

class UpdateSystem extends System {

	public function new() {}

	override function initialize() {
		Lib.current.stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);
	}

	function onEnterFrame(_) {
		for (system in world.systems()) {
			system.update();
			world.invalidate();
		}
	}
}
