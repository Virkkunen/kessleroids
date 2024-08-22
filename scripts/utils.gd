extends Node

func wrap_around(position: Vector2) -> Vector2:
	if position.x > Global.screen_size.x:
		position.x = 0
	elif position.x < 0:
		position.x = Global.screen_size.x
	if position.y > Global.screen_size.y:
		position.y = 0
	elif position.y < 0:
		position.y = Global.screen_size.y
	return position

func detect_collision() -> void:
	pass

func click_sound() -> void:
	var audio_player = AudioStreamPlayer.new()
	audio_player.stream = load("res://assets/sfx/click.wav")
	add_child(audio_player)
	audio_player.play()
	audio_player.finished.connect(queue_free)
