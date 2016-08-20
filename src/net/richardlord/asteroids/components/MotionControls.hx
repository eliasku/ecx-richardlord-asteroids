package net.richardlord.asteroids.components;

import ecx.Component;

class MotionControls extends Component {

	public var left:Int;
	public var right:Int;
	public var accelerate:Int;

	public var accelerationRate:Float;
	public var rotationRate:Float;

	public function new() {}

	public function setup(left:Int, right:Int, accelerate:Int, accelerationRate:Float, rotationRate:Float) {
		this.left = left;
		this.right = right;
		this.accelerate = accelerate;
		this.accelerationRate = accelerationRate;
		this.rotationRate = rotationRate;
	}
}
