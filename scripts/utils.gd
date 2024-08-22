extends Node

func wrap_around(position: Vector2) -> Vector2:
	if position.x > Global.screen_size.x:
		position.x = 0
	elif position.x < 0:
		position.x = Global.screen_size.x
	if position.y > Global.screen_size.y:
		position.y = 0
	elif position.y < 0:
		position.y = Global.screen_size.y
	return position

func detect_collision() -> void:
	pass
