package net.richardlord.asteroids.core;

import ecx.EntityView;
import ecx.Component;

class Fsm extends Component {

	var _currentState:String;
	var _nextState:String;

	var _added:Map<String, EntityView->Void> = new Map();
	var _removed:Map<String, EntityView->Void> = new Map();

	public function new() {}

	public function changeState(newState:String) {
		_nextState = newState;
	}

	public function createState(name:String, added:EntityView->Void, removed:EntityView->Void) {
		_added.set(name, added);
		_removed.set(name, removed);
	}
}
