extends RigidBody2D

@onready var utils = load("res://scripts/utils.gd").new()
@onready var collision_polygon: CollisionPolygon2D = $Hitbox
@onready var audio_asteroid_break: AudioStreamPlayer = $asteroid_break

@export var min_size = 24
@export var max_size = 128
var radius = randf_range(min_size, max_size)

func _ready():
	add_to_group("Asteroids")
	custom_integrator = true
	
func _draw():
	var points = []
	var num_points = randi() % 5 + 5
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

func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	# controlled on inspector
	#gravity_scale = 0.0
	#linear_damp = 0.0
	#angular_damp = 0.0
	position = utils.wrap_around(position)
#
func remove_asteroid() -> void:
	# so the breaking sound can play from the asteroids position
	# after it breaks, then it can properly remove it 
	collision_polygon.queue_free()
	freeze = true # apparently does jack shit
	linear_velocity = Vector2(0.0, 0.0)
	angular_velocity = 0.0
	collision_polygon.disabled = true # apparently also does jack shit
	visible = false
	audio_asteroid_break.finished.connect(queue_free)
	audio_asteroid_break.play()
