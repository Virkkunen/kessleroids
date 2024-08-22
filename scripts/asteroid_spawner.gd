extends Node2D

var Asteroid = preload("res://scenes/asteroid.tscn")
@onready var utils : Node = load("res://scripts/utils.gd").new()

var screen_center = Vector2(Global.screen_size.x / 2, Global.screen_size.y / 2)
#const min_distance_from_center = 100

func _ready() -> void:
	spawn_asteroids(randi() % 6 + 3, [])
	
func spawn_asteroids(num_asteroids: int, positions: Array) -> void:
	#var num_Asteroids = randi() % 6 + 3 # spawn from 3 to 5 asteroids on start
	for i in range(num_asteroids):
		var asteroid_instance = Asteroid.instantiate()
		
		# randomise the size and rotation
		var scale_factor = randf_range(0.5, 8)
		var starting_rotation = randf_range(0, 2 * PI)
		var starting_impulse = Vector2(randf_range(-250, 250), randf_range(-250, 250))
		
		# randomise starting position
		asteroid_instance.position = Vector2(randf_range(0, Global.screen_size.x), randf_range(0, Global.screen_size.y))
		
		add_child(asteroid_instance)
		utils.apply_impulse_to_body(asteroid_instance, starting_impulse, starting_rotation)
