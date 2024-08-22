extends Node2D

var player_scene = preload("res://scenes/player.tscn")
@export var player_instance = null


func _ready() -> void:
	spawn_player()
	
func _input(event: InputEvent) -> void:
	if Global.lives > 0 and event.is_action_pressed("respawn"):
		spawn_player()
	if event.is_action_pressed("quit"):
		get_tree().quit()
	
func _draw() -> void:
	draw_rect(Rect2(Vector2(0, 0), Global.screen_size), Global.colour02, false, Global.border_thickness)

func spawn_player() -> void:
	if is_instance_valid(player_instance):
		player_instance.queue_free()
	player_instance = player_scene.instantiate()
	add_child(player_instance)
	player_instance.position = Global.screen_size / 2

func death() -> void:
	if is_instance_valid(player_instance):
		player_instance.queue_free()
		Global.lives -= 1
		print("Lives: ", Global.lives)
		#if not audio_dead02.playing:
			#audio_dead02.play()
