package net.richardlord.asteroids.core;

import net.richardlord.asteroids.core.Fsm;
import ecx.Wire;
import ecx.Family;
import ecx.System;

class FsmSystem extends System {

	var _entities:Family<Fsm>;
	var _fsm:Wire<Fsm>;

	public function new() {}

	@:access(net.richardlord.asteroids.core)
	override function update() {
		for(entity in _entities) {
			var fsm:FsmData = _fsm.get(entity);
			if(fsm.state != fsm._next) {
				var exitCallback = fsm._exit.get(fsm.state);
				var enterCallback = fsm._enter.get(fsm._next);

				if(exitCallback != null) {
					exitCallback(world, entity);
				}
				if(enterCallback != null) {
					enterCallback(world, entity);
				}
				fsm.state = fsm._next;
				world.commit(entity);
			}
		}
	}
}
