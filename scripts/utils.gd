extends Node

func wrap_around(position: Vector2) -> Vector2:
	position.x = wrapf(position.x, 0, Global.screen_size.x)
	position.y = wrapf(position.y, 0, Global.screen_size.y)
	return position
	
func detect_collision() -> void:
	pass

func click_sound() -> void:
	var audio_player = AudioStreamPlayer.new()
	audio_player.stream = load("res://assets/sfx/click.wav")
	add_child(audio_player)
	audio_player.play()
	audio_player.finished.connect(queue_free)

func apply_impulse_to_body(body: RigidBody2D, velocity: Vector2, rotation: float) -> void:
	if body:
		body.linear_velocity = velocity
		body.rotation = rotation
