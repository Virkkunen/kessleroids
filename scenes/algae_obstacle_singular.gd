extends Node2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

@export var min_frame_time: float = 1.55
@export var max_frame_time: float = 0.7 

func _ready():
	_generate_random_frame_durations()
	animated_sprite.play()

func _generate_random_frame_durations():
	var animation = animated_sprite.animation
	var frame_count = animated_sprite.sprite_frames.get_frame_count(animation)
	for i in range(frame_count):
		var random_duration = randf_range(min_frame_time, max_frame_time)
		var texture = animated_sprite.sprite_frames.get_frame_texture(animation, i)
		animated_sprite.sprite_frames.set_frame(animation, i, texture, random_duration)

func get_current_animation_texture():
	var current_animation = animated_sprite.animation
	var current_frame = animated_sprite.frame
	var current_texture = animated_sprite.sprite_frames.get_frame_texture(current_animation, current_frame)
	
	return current_texture
