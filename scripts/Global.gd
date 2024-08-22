extends Node2D

@export var screen_size : Vector2
@export var colour01 : Color = Color.html("#222323")
@export var colour02 : Color = Color.html("#83b07e")
@export var border_thickness: float = 60.0
@export var game_over_scene = load("res://scenes/game_over.tscn")

var lives : int
var score : int
var dead = false
var game_over_instance : Node = null

signal lives_changed
signal score_changed

func _ready() -> void:
	screen_size = get_viewport_rect().size
			
func decrease_lives() -> void:
	if lives == 0:
		dead = true
		show_game_over()
	else:
		lives -= 1
	emit_signal("lives_changed")

func increase_score() -> void:
	score += 1
	emit_signal("score_changed")

func show_game_over() -> void:
	#if game_over_instance:
		#game_over_instance.queue_free()
	var game_over_instance = game_over_scene.instantiate()
	add_child(game_over_instance)
	game_over_instance.show_game_over_screen()
