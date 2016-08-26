package net.richardlord.asteroids;

import ecx.Service;
import flash.Lib;

class GameConfig extends Service {

	public var width(default, null):Float;
	public var height(default, null):Float;

	public function new() {}

	override function initialize() {
		width = Lib.current.stage.stageWidth;
		height = Lib.current.stage.stageHeight;
	}
}
