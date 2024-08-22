extends Control

@onready var play_button = $MenuLayer/PlayButton
@onready var help_button = $MenuLayer/HelpButton
@onready var credits_button = $MenuLayer/CreditsButton
@onready var quit_button = $MenuLayer/QuitButton
@onready var back_button = $BackButton

@onready var menu_layer = $MenuLayer
@onready var help_layer = $HelpLayer
@onready var credits_layer = $CreditsLayer
@onready var utils = preload("res://scripts/utils.gd").new()

const game_scene = "res://scenes/game.tscn"

func _ready() -> void:
	help_layer.visible = false
	credits_layer.visible = false
	back_button.visible = false
	menu_layer.visible = true
	#play_button.connect("pressed", Callable(self, "_on_play_button_pressed"))
	#help_button.connect("pressed", Callable(self, "_on_help_button_pressed"))
	#credits_button.connect("pressed", Callable(self, "_on_credits_button_pressed"))
	#quit_button.connect("pressed", Callable(self, "_on_quit_button_pressed"))
	#back_button.connect("pressed", Callable(self, "_on_back_button_pressed"))
	# let's use the godot 4 method
	play_button.pressed.connect(_on_play_button_pressed)
	help_button.pressed.connect(_on_help_button_pressed)
	credits_button.pressed.connect(_on_credits_button_pressed)
	quit_button.pressed.connect(_on_quit_button_pressed)
	back_button.pressed.connect(_on_back_button_pressed)
	
func _on_quit_button_pressed() -> void:
	get_tree().quit()

func _on_help_button_pressed() -> void:
	menu_layer.visible = false
	credits_layer.visible = false
	help_layer.visible = true
	back_button.visible = true
	utils.click_sound()
	
func _on_credits_button_pressed() -> void:
	menu_layer.visible = false
	help_layer.visible = false
	credits_layer.visible = true
	back_button.visible = true
	utils.click_sound()

func _on_back_button_pressed() -> void:
	help_layer.visible = false
	credits_layer.visible = false
	back_button.visible = false
	menu_layer.visible = true
	utils.click_sound()
	
func _on_play_button_pressed() -> void:
	utils.click_sound()
	get_tree().change_scene_to_file(game_scene)
	
