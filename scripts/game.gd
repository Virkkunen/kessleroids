extends Node2D

var player_scene = preload("res://scenes/player.tscn")
@export var player_instance = null

@onready var audio_death = $dead02
@onready var audio_respawn = $respawn
@onready var score_timer = $ScoreTimer
@onready var restart_hint = $RestartHint

func _ready() -> void:
	Global.connect("lives_changed", Callable(self, "_on_lives_changed"))
	Global.connect("score_changed", Callable(self, "_on_score_changed"))
	score_timer.connect("timeout", Callable(self, "_on_ScoreTimer_timeout"))
	Global.dead = false
	Global.lives = 1
	Global.score = 0
	update_lives_label()
	update_score_label()
	spawn_player()
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("respawn") and not is_instance_valid(player_instance) and not Global.dead:
		spawn_player()
	if event.is_action_pressed("quit"):
		#get_tree().quit()
		get_tree().change_scene_to_file("res://scenes/menu.tscn")
	
#func _draw() -> void:
	#draw_rect(Rect2(Vector2(0, 0), Global.screen_size), Global.colour02, false, Global.border_thickness)

func spawn_player() -> void:
	if not audio_respawn.playing:
		audio_respawn.play()
	restart_hint.visible = false
	if is_instance_valid(player_instance):
		player_instance.queue_free()
	player_instance = player_scene.instantiate()
	add_child(player_instance)
	player_instance.position = Global.screen_size / 2
	score_timer.start()

func get_hit() -> void:
	if is_instance_valid(player_instance):
		if not audio_death.playing:
			audio_death.play()
		player_instance.queue_free()
		Global.decrease_lives()
		score_timer.stop()
		restart_hint.visible = true
		
func _on_lives_changed() -> void:
	update_lives_label()
	
func _on_score_changed() -> void:
	update_score_label()

func _on_ScoreTimer_timeout() -> void:
	Global.increase_score()

func update_lives_label() -> void:
	var lives_label = $"MarginLives/LivesLabel"
	lives_label.text = "Lives: " + str(Global.lives)
	
func update_score_label() -> void:
	var score_label = $MarginScore/ScoreLabel
	score_label.text = "Score: " + str(Global.score)
