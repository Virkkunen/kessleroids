extends Node2D

var Asteroid = preload("res://scenes/asteroid.tscn")

func _ready() -> void:
	spawn_asteroids()
	
func spawn_asteroids() -> void:
	var num_Asteroids = randi() % 6 + 3 # spawn from 1 to 5 asteroids on start
	for i in range(num_Asteroids):
		var asteroid_instance = Asteroid.instantiate()
		
		# randomise the size and rotation
		var scale_factor = randf_range(0.5, 5)
		asteroid_instance.scale = Vector2(scale_factor, scale_factor)
		asteroid_instance.rotation = randf_range(0, 2 * PI)
		
		# randomise starting position
		asteroid_instance.position = Vector2(randf_range(0, Global.screen_size.x), randf_range(0, Global.screen_size.y))
		
		add_child(asteroid_instance)
