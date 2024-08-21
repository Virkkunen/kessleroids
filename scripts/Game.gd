extends Node2D

@export var screenSize = Vector2()

func _ready() -> void:
	screenSize = get_viewport_rect().size
