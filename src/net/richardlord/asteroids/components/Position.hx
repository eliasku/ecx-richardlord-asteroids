package net.richardlord.asteroids.components;

import ecx.storage.AutoComp;
import flash.geom.Point;

class Position extends AutoComp<PositionData> {}

class PositionData {

	public var position:Point;
	public var rotation:Float;

	public function new() {}

	public function setup(x:Float, y:Float, rotation:Float) {
		position = new Point(x, y);
		this.rotation = rotation;
	}
}
