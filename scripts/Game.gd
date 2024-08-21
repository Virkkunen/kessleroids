extends Node2D

@export var screenSize : Vector2

@export var colour01 : Color = Color.html("#222323")
@export var colour02 : Color = Color.html("#83b07e")
#@export var colour03 = Color.html("#306230")
#@export var colour04 = Color.html("#0f380f")

@export var border_thickness: float = 60.0

var lives : int = 3

var player_scene = preload("res://scenes/player.tscn")
@export var player_instance = null

func _ready() -> void:
	screenSize = get_viewport_rect().size
	spawn_player()
	
func _input(event: InputEvent) -> void:
	if lives > 0 and event.is_action_pressed("respawn"):
		spawn_player()
	if event.is_action_pressed("quit"):
		get_tree().quit()
		
func _draw() -> void:
	draw_rect(Rect2(Vector2(0, 0), screenSize), colour02, false, border_thickness)
	
func spawn_player() -> void:
	if is_instance_valid(player_instance):
		player_instance.queue_free()
	player_instance = player_scene.instantiate()
	add_child(player_instance)
	player_instance.position = screenSize / 2

func death() -> void:
	if is_instance_valid(player_instance):
		player_instance.queue_free()
		lives -= 1
		print(lives)
		#if not audio_dead02.playing:
			#audio_dead02.play()
			
func update_lives() -> void:
	lives_label.text = "Lives: " + str(Game.lives)
	
func _on_lives_changed():
	update_lives()
