package net.richardlord.asteroids.core;

import ecx.MapTo;
import ecx.Family;
import ecx.System;

class FsmSystem extends System{

	var _entities:Family<Fsm>;
	var _fsm:MapTo<Fsm>;

	public function new() {}

	@:access(net.richardlord.asteroids.core.Fsm)
	override function update() {
		for(entity in _entities) {
			var fsm = _fsm.get(entity);
			if(fsm._currentState != fsm._nextState) {
				var entityEdit = world.edit(entity);
				var stateAdded = fsm._added.get(fsm._nextState);
				var stateRemoved = fsm._removed.get(fsm._currentState);
				if(stateRemoved != null) {
					stateRemoved(entityEdit);
				}
				if(stateAdded != null) {
					stateAdded(entityEdit);
				}
				fsm._currentState = fsm._nextState;
			}
		}
	}
}
