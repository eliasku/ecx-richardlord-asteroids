package net.richardlord.asteroids.components;

import ecx.AutoComp;

class GameState extends AutoComp<GameStateData> {}

class GameStateData {

	public var lives:Int = 3;
	public var level:Int = 0;
	public var points:Int = 0;

	public function new() {}
}
