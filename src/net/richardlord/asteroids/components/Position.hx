package net.richardlord.asteroids.components;

import ecx.Component;
import flash.geom.Point;

class Position extends Component {

	public var position:Point;
	public var rotation:Float;

	public function new() {}

	public function setup(x:Float, y:Float, rotation:Float) {
		position = new Point(x, y);
		this.rotation = rotation;
	}
}
