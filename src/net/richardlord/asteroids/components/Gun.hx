package net.richardlord.asteroids.components;

import ecx.Component;
import flash.geom.Point;

class Gun extends Component {

	public var shooting:Bool = false;
	public var offsetFromParent:Point;
	public var timeSinceLastShot:Float = 0;
	public var minimumShotInterval:Float = 0;
	public var bulletLifetime:Float = 0;
	public var spreadAngle:Float = 0;

	public function new() {}

	public function setup(offsetX:Float, offsetY:Float, minimumShotInterval:Float, bulletLifetime:Float, spreadAngle:Float) {
		offsetFromParent = new Point(offsetX, offsetY);
		this.minimumShotInterval = minimumShotInterval;
		this.bulletLifetime = bulletLifetime;
		this.spreadAngle = spreadAngle;
	}
}
