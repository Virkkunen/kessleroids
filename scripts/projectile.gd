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
	var max_size = asteroid.max_size
	var min_size = asteroid.min_size
	if max_size > min_size * 2:
		for i in randi_range(3, 6):
			var new_asteroid = preload("res://scenes/asteroid.tscn").instantiate()
			new_asteroid.position = position
			new_asteroid.max_size = max_size / 2
			new_asteroid.min_size = min_size
			new_asteroid.linear_velocity = asteroid.linear_velocity.rotated(randf_range(-PI / 4, PI / 4))
			get_parent().add_child(new_asteroid)
	asteroid.queue_free()
