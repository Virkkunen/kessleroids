extends Node2D

var Asteroid = preload("res://scenes/asteroid.tscn")
@onready var utils : Node = load("res://scripts/utils.gd").new()

var screen_center = Global.screen_size / 2
const min_distance_from_center = 300

func _ready() -> void:
	spawn_asteroids(randi() % 12 + 8, true)
	#spawn_asteroids(0, [])
	
#func spawn_asteroids(num_asteroids: int) -> void:
	##var num_Asteroids = randi() % 6 + 3 # spawn from 3 to 5 asteroids on start
	#for i in range(num_asteroids):
		#var asteroid_instance = Asteroid.instantiate()
		#
		## randomise the size and rotation
		#var scale_factor = randf_range(0.5, 8)
		#var starting_rotation = randf_range(0, 2 * PI)
		#var starting_impulse = Vector2(randf_range(-250, 250), randf_range(-250, 250)) * 1.5
		#
		## randomise starting position
		#asteroid_instance.position = Vector2(randf_range(0, Global.screen_size.x), randf_range(0, Global.screen_size.y))
		#
		#add_child(asteroid_instance)
		#utils.apply_impulse_to_body(asteroid_instance, starting_impulse, starting_rotation)

func spawn_asteroids(num_asteroids: int, initial_spawn: bool) -> void:
	for i in range(num_asteroids):
		var asteroid = Asteroid.instantiate() as RigidBody2D
		var position: Vector2
		
		# spaghetti warning
		if initial_spawn:
			while true:
				position = Vector2(randf_range(0, Global.screen_size.x), randf_range(0, Global.screen_size.y))
				if position.distance_to(screen_center) >= min_distance_from_center:
					break
		else:
			position = Vector2(randf_range(0, Global.screen_size.x), randf_range(0, Global.screen_size.y))
		
		asteroid.position = position
		
		# Assign velocity and direction
		var direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
		var speed = randf_range(50, 150)
		asteroid.linear_velocity = direction * speed
		asteroid.angular_velocity = randf_range(0, 2)
		add_child(asteroid)
