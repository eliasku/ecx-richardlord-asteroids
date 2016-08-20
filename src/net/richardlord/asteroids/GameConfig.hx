package net.richardlord.asteroids;

import flash.Lib;
import ecx.System;

class GameConfig extends System {

	public var width(default, null):Float;
	public var height(default, null):Float;

	public function new() {}

	override function initialize() {
		width = Lib.current.stage.stageWidth;
		height = Lib.current.stage.stageHeight;
	}
}
