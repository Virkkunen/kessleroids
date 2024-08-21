extends Node

func wrap_around(position: Vector2) -> Vector2:
	if position.x > Game.screenSize.x - Game.border_thickness:
		position.x = Game.border_thickness
	elif position.x < Game.border_thickness:
		position.x = Game.screenSize.x - Game.border_thickness
	if position.y > Game.screenSize.y - Game.border_thickness:
		position.y = Game.border_thickness
	elif position.y < Game.border_thickness:
		position.y = Game.screenSize.y - Game.border_thickness
	return position
