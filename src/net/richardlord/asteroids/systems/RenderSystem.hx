package net.richardlord.asteroids.systems;

import ecx.Wire;
import ecx.Entity;
import ecx.Family;
import ecx.System;
import flash.Lib;
import flash.display.DisplayObjectContainer;
import net.richardlord.asteroids.components.Display;
import net.richardlord.asteroids.components.Position;

class RenderSystem extends System {

	var _container:DisplayObjectContainer;

	var _entities:Family<Display, Position>;
	var _position:Wire<Position>;
	var _display:Wire<Display>;

	public function new() {
		_container = Lib.current.stage;
	}

	override function onEntityAdded(entity:Entity, _) {
		var sprite = _display.get(entity);
		var position = _position.get(entity);
		sprite.x = position.position.x;
		sprite.y = position.position.y;
		sprite.rotation = position.rotation * 180 / Math.PI;
		_container.addChild(sprite);
	}

	override function onEntityRemoved(entity:Entity, _) {
		_container.removeChild(_display.get(entity));
	}

	override function update() {
		for (entity in _entities) {
			var sprite = _display.get(entity);
			var position = _position.get(entity);

			sprite.x = position.position.x;
			sprite.y = position.position.y;
			sprite.rotation = position.rotation * 180 / Math.PI;
		}
	}
}
