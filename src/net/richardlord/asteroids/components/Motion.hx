package net.richardlord.asteroids.components;

import flash.geom.Point;
import ecx.AutoComp;

class Motion extends AutoComp<MotionData> {}

class MotionData {

	public var velocity:Point;
	public var angularVelocity:Float;
	public var damping:Float;

	public function new() {}

	public function setup(velocityX:Float, velocityY:Float, angularVelocity:Float, damping:Float) {
		velocity = new Point( velocityX, velocityY );
		this.angularVelocity = angularVelocity;
		this.damping = damping;
	}
}
