package net.richardlord.asteroids.components;

import ecx.storage.AutoComp;
import flash.geom.Point;

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
