extends Node2D

@export var screen_size : Vector2

@export var colour01 : Color = Color.html("#222323")
@export var colour02 : Color = Color.html("#83b07e")
@export var border_thickness: float = 60.0

var lives : int = 3

var player_scene = preload("res://scenes/player.tscn")
@export var player_instance = null

func _ready() -> void:
	screen_size = get_viewport_rect().size


			
func update_lives() -> void:
	pass
	
func _on_lives_changed():
	update_lives()
