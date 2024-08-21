extends Node2D

var boost_active = false

func _draw() -> void:
	var points = [
		Vector2(-8, 4),
		Vector2(0, -12),
		Vector2(8, 4),
		Vector2(0, 8)
	]
	draw_polygon(points, [Game.colour02])
	
	if boost_active:
		var boost_flame_r = [
			Vector2(1, 4),
			Vector2(6, 12),
			Vector2(8, 4),
		]
		var boost_flame_l = [
			Vector2(-1, 4),
			Vector2(-6, 12),
			Vector2(-8, 4),
		]
		draw_polygon(boost_flame_r, [Game.colour02])
		draw_polygon(boost_flame_l, [Game.colour02])

func set_boost_active(active: bool) -> void:
	boost_active = active
	queue_redraw()
