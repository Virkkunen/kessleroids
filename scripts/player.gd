extends CharacterBody2D

# setup
var speed = 200
var maxSpeed = 420
var rotationSpeed = 3
var brakeSpeed = 120

var Projectile = preload("res://scenes/projectile.tscn")

@onready var utils = load("res://scripts/utils.gd").new()
@onready var ship_vector : Node2D = $ShipVector

func _physics_process(delta: float) -> void:
	### MOVEMENT
	# rotate
	if Input.is_action_pressed("rotate_left"):
		rotation -= rotationSpeed * delta
	elif Input.is_action_pressed("rotate_right"):
		rotation += rotationSpeed * delta
		
	# move
	if Input.is_action_pressed("boost"):
		ship_vector.set_boost_active(true)
		velocity += Vector2(0, -speed).rotated(rotation) * delta
		if velocity.length() > maxSpeed:
			velocity = velocity.normalized() * maxSpeed
	elif Input.is_action_pressed("brake"):
		# nested ifs this early
		if velocity.length() > 0:
			velocity = velocity.move_toward(Vector2.ZERO, brakeSpeed * delta)
	else:
		ship_vector.set_boost_active(false)

	# applyu movement
	move_and_slide()
	# get collisions
	for i in get_slide_collision_count():
		var collision := get_slide_collision(i)
		var body := collision.get_collider()
		print("Collided with: ", body)
		if body.is_in_group("Asteroids"):
			get_hit()
			body.velocity = Vector2(0, -speed).rotated(rotation) * 0.25
			body.angular_velocity = velocity.length() * 0.08
			print("Velocity: ", body.velocity.length())
			print("Angular Velocity: ", body.angular_velocity)
	
	# wrap around screen edges
	position = utils.wrap_around(position)
		
	### SHOOTING
	if Input.is_action_just_pressed("shoot"):
		shoot()
	
func shoot() -> void:
	var proj = Projectile.instantiate()
	proj.global_position = $Muzzle.global_position
	proj.rotation = rotation
	get_parent().add_child(proj)
	
###

func get_hit() -> void:
	if is_instance_valid(Game.player_instance):
		Game.player_instance.queue_free()
