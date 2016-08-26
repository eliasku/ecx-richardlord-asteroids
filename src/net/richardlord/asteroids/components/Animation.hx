package net.richardlord.asteroids.components;

import ecx.storage.AutoComp;
import net.richardlord.asteroids.graphics.IAnimatable;

class Animation extends AutoComp<AnimationHolder> {}

// TODO: make ValueComp<T>
class AnimationHolder {
	public var animation:IAnimatable;
	public function new() {}
}