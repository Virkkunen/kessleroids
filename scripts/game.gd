extends Node2D

@export var player_scene = preload("res://scenes/player.tscn")
@export var player_instance = null

@onready var audio_death = $dead02
@onready var audio_respawn = $respawn
@onready var score_timer = $ScoreTimer
@onready var asteroid_timer = $AsteroidTimer
@onready var restart_hint = $RestartHint
@onready var asteroid_spawner = $AsteroidSpawner

func _ready() -> void:
	Global.lives_changed.connect(_on_lives_changed)
	Global.score_changed.connect(_on_score_changed)
	score_timer.timeout.connect(_on_ScoreTimer_timeout)
	asteroid_timer.timeout.connect(_on_AsteroidTimer_timeout)
	Global.dead = false
	Global.lives = 3
	Global.score = 0
	update_lives_label()
	update_score_label()
	spawn_player()
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("respawn") and not is_instance_valid(player_instance) and not Global.dead:
		spawn_player()
	if event.is_action_pressed("quit"):
		get_tree().change_scene_to_file("res://scenes/menu.tscn")

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
	asteroid_timer.start()

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
	
func _on_AsteroidTimer_timeout() -> void:
	asteroid_spawner.spawn_asteroids(randi_range(1, 3))
	
func update_lives_label() -> void:
	var lives_label = $"HUD/MarginLives/LivesLabel"
	lives_label.text = "Lives: " + str(Global.lives)
	
func update_score_label() -> void:
	var score_label = $HUD/MarginScore/ScoreLabel
	score_label.text = "Score: " + str(Global.score)
