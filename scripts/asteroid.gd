extends CharacterBody2D

var angular_velocity = 0.2

@onready var utils = load("res://scripts/utils.gd").new()
@onready var collision_polygon: CollisionPolygon2D = $Hitbox

func _ready():
	collision_polygon = CollisionPolygon2D.new()
	add_child(collision_polygon)
	queue_redraw()
	add_to_group("Asteroids")
	
func _draw():
	var points = []
	var num_points = randi() % 5 + 5
	var radius = 24
	
	for i in range(num_points):
		# here comes the math
		var angle = i * 2 * PI / num_points
		var offset = randf() * 0.4 + 0.8
		var x = cos(angle) * radius * offset
		var y = sin(angle) * radius * offset
		points.append(Vector2(x, y))
		
	draw_polygon(points, [Game.colour02])
	
	collision_polygon.polygon = points

func _physics_process(delta: float) -> void:
	rotation += angular_velocity * delta
	
	move_and_slide()
		
	for i in get_slide_collision_count():
		var collision := get_slide_collision(i)
		var body := collision.get_collider()
		if body.is_in_group("Asteroids"):
			var transfer_velocity = velocity * 2 / 3
			var transfer_angular_velocity = angular_velocity * 2 / 3
		
			body.velocity += transfer_velocity
			body.angular_velocity += transfer_angular_velocity
			velocity = -transfer_velocity
			angular_velocity = -transfer_angular_velocity
		
	# wrap around screen edges
	position = utils.wrap_around(position)
