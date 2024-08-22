extends Node2D

@export var screen_size : Vector2
@export var colour01 : Color = Color.html("#222323")
@export var colour02 : Color = Color.html("#83b07e")
@export var border_thickness: float = 60.0

var lives : int = 3
var score : int = 0

signal lives_changed
signal score_changed

func _ready() -> void:
	screen_size = get_viewport_rect().size
			
func decrease_lives() -> void:
	lives -= 1
	emit_signal("lives_changed")

func increase_score() -> void:
	score += 1
	emit_signal("score_changed")
