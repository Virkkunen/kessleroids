extends CanvasLayer

@onready var score_label = $ScoreLabel
@onready var restart_button = $RestartButton
@onready var quit_button = $QuitButton
@onready var audio_game_over = $GameOverAudio

@onready var hud = $/root/Game/HUD

func _ready() -> void:
	audio_game_over.play()
	restart_button.pressed.connect(_on_restart_button_pressed)
	quit_button.pressed.connect(_on_quit_button_pressed)

func show_game_over_screen() -> void:
	score_label.text = "Score: " + str(Global.score)
	hud.visible = false
	visible = true

func _on_restart_button_pressed() -> void:
	queue_free()
	get_tree().reload_current_scene()

func _on_quit_button_pressed() -> void:
	get_tree().quit()
