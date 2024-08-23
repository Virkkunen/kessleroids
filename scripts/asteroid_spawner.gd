extends Node2D

var Asteroid = preload("res://scenes/asteroid.tscn")
@onready var utils : Node = load("res://scripts/utils.gd").new()

var screen_center = Global.screen_size / 2
const min_distance_from_center = 300

@export var existing_asteroids = []

func _ready() -> void:
	spawn_asteroids(randi() % 12 + 8, true)
	#spawn_asteroids(0, [])

func spawn_asteroids(num_asteroids: int, initial_spawn: bool) -> void:
	for i in range(num_asteroids):
		var asteroid = Asteroid.instantiate()
		var position: Vector2

		# To prevent asteroids spawning on each other
		# proud Italian with so much spaghetti
		if initial_spawn:
			while true:
				position = gen_random_position()
				if position.distance_to(screen_center) < min_distance_from_center:
					continue # inside the safe radius, so do the loop again
				# now check against the existing_asteroids
				var valid_position = true
				for other_asteroid in existing_asteroids:
					if position.distance_to(other_asteroid.position) < asteroid.radius:
						valid_position = false
						break

				if valid_position:
					break # position is valid so stop the loop
			existing_asteroids.append(asteroid)
		else:
			position = gen_random_position()

		asteroid.position = position

		# Assign velocities, direction
		var direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
		var speed = randf_range(50, 150)
		asteroid.linear_velocity = direction * speed
		asteroid.angular_velocity = randf_range(0, 2)

		add_child(asteroid)

func gen_random_position() -> Vector2:
	return Vector2(randf_range(0, Global.screen_size.x), randf_range(0, Global.screen_size.y))
