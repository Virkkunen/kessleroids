extends Node

func wrap_around(position: Vector2) -> Vector2:
	if position.x > Global.screen_size.x - Global.border_thickness:
		position.x = Global.border_thickness
	elif position.x < Global.border_thickness:
		position.x = Global.screen_size.x - Global.border_thickness
	if position.y > Global.screen_size.y - Global.border_thickness:
		position.y = Global.border_thickness
	elif position.y < Global.border_thickness:
		position.y = Global.screen_size.y - Global.border_thickness
	return position

func detect_collision() -> void:
	pass
