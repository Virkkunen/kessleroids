extends RigidBody2D

@onready var utils = load("res://scripts/utils.gd").new()
@onready var collision_polygon: CollisionPolygon2D = $Hitbox

func _ready():
	add_to_group("Asteroids")
	custom_integrator = true
	print(linear_velocity)
	#gravity_scale = 0.0
	#linear_damp = 0.0
	#angular_damp = 0.0
	
func _draw():
	var points = []
	var num_points = randi() % 5 + 5
	var radius = randf_range(24, 128)

	#var radius = 24
	
	for i in range(num_points):
		# here comes the math
		var angle = i * 2 * PI / num_points
		var offset = randf() * 0.4 + 0.8
		var x = cos(angle) * radius * offset
		var y = sin(angle) * radius * offset
		points.append(Vector2(x, y))
		
	draw_polygon(points, [Global.colour02])
	
	collision_polygon.polygon = points

#func _physics_process(delta: float) -> void:
	#angular_velocity = randf_range(0.1, 0.6)
	#rotation += angular_velocity * delta
	
	# wrap around screen edges

func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	#gravity_scale = 0.0
	gravity_scale = 0.0
	linear_damp = 0.0
	angular_damp = 0.0
	position = utils.wrap_around(position)

func _on_body_entered(body: Node) -> void:
	print("Asteroid collided with: ", body)
	if body.is_in_group("Asteroids"):
		utils.apply_force_to_body(body, linear_velocity, rotation)
