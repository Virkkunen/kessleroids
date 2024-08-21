extends Node2D

@export var screenSize = Vector2()

var player_scene = preload("res://scenes/player.tscn")
@export var player_instance = null

func _ready() -> void:
	screenSize = get_viewport_rect().size
	spawn_player()
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("respawn"):
		spawn_player()
	
func spawn_player() -> void:
	if is_instance_valid(player_instance):
		player_instance.queue_free()
	player_instance = player_scene.instantiate()
	add_child(player_instance)
	player_instance.position = screenSize / 2
