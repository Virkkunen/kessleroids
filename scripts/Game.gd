extends Node2D

@export var screenSize = Vector2()

@export var colour01 = Color().html("#9bbc0f")
@export var colour02 = Color().html("#8bac0f")
@export var colour03 = Color().html("#306230")
@export var colour04 = Color().html("#0f380f")

@export var border_thickness: float = 60.0

var player_scene = preload("res://scenes/player.tscn")
@export var player_instance = null

func _ready() -> void:
	screenSize = get_viewport_rect().size
	spawn_player()
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("respawn"):
		spawn_player()
	if event.is_action_pressed("quit"):
		get_tree().quit()
		
func _draw() -> void:
	draw_rect(Rect2(Vector2(0, 0), screenSize), colour03, false, border_thickness)
	
func spawn_player() -> void:
	if is_instance_valid(player_instance):
		player_instance.queue_free()
	player_instance = player_scene.instantiate()
	add_child(player_instance)
	player_instance.position = screenSize / 2
