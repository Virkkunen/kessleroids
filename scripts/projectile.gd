extends Area2D

@export var speed = 600
#var lifetime = 5

@onready var collision_polygon: CollisionPolygon2D = $Hitbox
@onready var utils = load("res://scripts/utils.gd").new()

func _ready() -> void:
	add_to_group("Projectiles")

func _physics_process(delta: float) -> void:
	position += Vector2(0, -speed * delta).rotated(rotation)
	position = utils.wrap_around(position)

func _draw() -> void:
	var points = [
		Vector2(-4, 0),
		Vector2(0, -4),
		Vector2(4, 0),
		Vector2(0, 4)
	]
	draw_polygon(points, [Global.colour02])
	collision_polygon.polygon = points

func _on_body_entered(body: Node2D) -> void:
	print("Projectile collided with: ", body)
	if body.is_in_group("Asteroids"):
		split_asteroid(body)
	queue_free()

func split_asteroid(asteroid: Node2D) -> void:
	var new_size = asteroid.radius / 2
	if new_size >= 12:
		var num_chunks = randi_range(3, 6)
		for i in range(num_chunks):
			var new_asteroid = preload("res://scenes/asteroid.tscn").instantiate()
			new_asteroid.position = asteroid.position
			new_asteroid.max_size = new_size
			new_asteroid.radius = randf_range(12, new_size)
			#var new_impulse = asteroid.linear_velocity.rotated(randf_range(0, 2 * PI)) * 4
			#var new_rotation = randf_range(0, 2 * PI)
			#new_asteroid.angular_velocity = asteroid.angular_velocity * 2
			var direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
			speed = randf_range(200, 400)
			new_asteroid.linear_velocity = direction * speed
			new_asteroid.angular_velocity = randf_range(0, 20)
			get_parent().add_child(new_asteroid)
			#utils.apply_impulse_to_body(new_asteroid, new_impulse, new_rotation)
	asteroid.remove_asteroid()
