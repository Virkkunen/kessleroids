extends CanvasLayer

@onready var score_label = $ScoreLabel
@onready var restart_button = $RestartButton
@onready var quit_button = $QuitButton

@onready var score_label_screen = $"/root/Game/MarginScore/ScoreLabel"
@onready var lives_label_screen = $"/root/Game/MarginLives/LivesLabel"

func _ready() -> void:
	restart_button.connect("pressed", Callable(self, "_on_restart_button_pressed"))
	quit_button.connect("pressed", Callable(self, "_on_quit_button_pressed"))

func show_game_over_screen() -> void:
	score_label.text = "Score: " + str(Global.score)
	lives_label_screen.visible = false
	score_label_screen.visible = false
	visible = true
	
func _on_restart_button_pressed() -> void:
	queue_free()
	get_tree().reload_current_scene()
	
func _on_quit_button_pressed() -> void:
	get_tree().quit()
