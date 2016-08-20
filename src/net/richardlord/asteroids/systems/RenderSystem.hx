package net.richardlord.asteroids.systems;

import ecx.Entity;
import ecx.MapTo;
import ecx.Family;
import ecx.System;
import flash.Lib;
import flash.display.DisplayObjectContainer;
import net.richardlord.asteroids.components.Display;
import net.richardlord.asteroids.components.Position;

class RenderSystem extends System {

	var _container:DisplayObjectContainer;

	var _entities:Family<Display, Position>;
	var _position:MapTo<Position>;
	var _display:MapTo<Display>;

	public function new() {
		_container = Lib.current.stage;
	}

	override function onEntityAdded(entity:Entity, _) {
		var display = _display.get(entity);
		var position = _position.get(entity);
		display.sprite.x = position.position.x;
		display.sprite.y = position.position.y;
		display.sprite.rotation = position.rotation * 180 / Math.PI;
		_container.addChild(display.sprite);
	}

	override function onEntityRemoved(entity:Entity, _) {
		_container.removeChild(_display.get(entity).sprite);
	}

	override function update() {
		for (entity in _entities) {
			var sprite = _display.get(entity).sprite;
			var position = _position.get(entity);

			sprite.x = position.position.x;
			sprite.y = position.position.y;
			sprite.rotation = position.rotation * 180 / Math.PI;
		}
	}
}
