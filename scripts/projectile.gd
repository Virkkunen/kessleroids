extends Area2D

var speed = 600
var lifetime = 5

@onready var collision_polygon: CollisionPolygon2D = $Hitbox
@onready var utils = load("res://scripts/utils.gd").new()

func _ready() -> void:
	# to delete the projectile after its lifetime
	await get_tree().create_timer(lifetime).timeout
	queue_free()
	
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
	draw_polygon(points, [Game.colour02])
	collision_polygon.polygon = points
