extends Control

@onready var play_button = $MenuLayer/PlayButton
@onready var help_button = $MenuLayer/HelpButton
@onready var credits_button = $MenuLayer/CreditsButton
@onready var quit_button = $MenuLayer/QuitButton
@onready var back_button = $BackButton

@onready var menu_layer = $MenuLayer
@onready var help_layer = $HelpLayer
@onready var credits_layer = $CreditsLayer

const game_scene = "res://scenes/game.tscn"

func _ready() -> void:
	help_layer.visible = false
	credits_layer.visible = false
	back_button.visible = false
	menu_layer.visible = true
	play_button.connect("pressed", Callable(self, "_on_play_button_pressed"))
	help_button.connect("pressed", Callable(self, "_on_help_button_pressed"))
	credits_button.connect("pressed", Callable(self, "_on_credits_button_pressed"))
	quit_button.connect("pressed", Callable(self, "_on_quit_button_pressed"))
	back_button.connect("pressed", Callable(self, "_on_back_button_pressed"))
	
func _on_quit_button_pressed() -> void:
	get_tree().quit()

func _on_help_button_pressed() -> void:
	menu_layer.visible = false
	credits_layer.visible = false
	help_layer.visible = true
	help_menu()
	
func _on_credits_button_pressed() -> void:
	menu_layer.visible = false
	help_layer.visible = true
	credits_menu()
	
func help_menu() -> void:
	back_button.visible = true
	
func credits_menu() -> void:
	back_button.visible = true

func _on_back_button_pressed() -> void:
	help_layer.visible = false
	credits_layer.visible = false
	back_button.visible = false
	menu_layer.visible = true
	
func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file(game_scene)
	
