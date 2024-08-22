extends CharacterBody2D

# setup
var speed = 200
var maxSpeed = 420
var rotationSpeed = 3
var brakeSpeed = 120
var boost_active = false

var Projectile = preload("res://scenes/projectile.tscn")

@onready var game = $"/root/Game"

@onready var utils = load("res://scripts/utils.gd").new()
@onready var ship_vector : Node2D = $ShipVector

@onready var audio_boost = $boost
@onready var audio_brake = $brake
@onready var audio_shot = $shot

func _physics_process(delta: float) -> void:
	### MOVEMENT
	# rotate
	if Input.is_action_pressed("rotate_left"):
		rotation -= rotationSpeed * delta
	elif Input.is_action_pressed("rotate_right"):
		rotation += rotationSpeed * delta
		
	# move
	if Input.is_action_pressed("boost"):
		set_boost_active(true)
		velocity += Vector2(0, -speed).rotated(rotation) * delta
		
		if not audio_boost.playing:
			audio_boost.play()
		
		if velocity.length() > maxSpeed:
			velocity = velocity.normalized() * maxSpeed

	elif Input.is_action_pressed("brake"):
		if not audio_brake.playing:
			audio_brake.play()
		if velocity.length() > 0:
			velocity = velocity.move_toward(Vector2.ZERO, brakeSpeed * delta)
	else:
		set_boost_active(false)

	# applyu movement
	move_and_slide()
	# get collisions
	for i in get_slide_collision_count():
		var collision := get_slide_collision(i)
		var body := collision.get_collider()
		print("Collided with: ", body)
		if body.is_in_group("Asteroids"):
			body.velocity = Vector2(0, -speed).rotated(rotation) * 0.25
			body.angular_velocity = velocity.length() * 0.08
			print("Velocity: ", body.velocity.length())
			print("Angular Velocity: ", body.angular_velocity)
	
	# wrap around screen edges
	position = utils.wrap_around(position)
		
	# SHOOTING
	if Input.is_action_just_pressed("shoot"):
		shoot()
		
func _draw() -> void:
	var points = [
		Vector2(-8, 4),
		Vector2(0, -12),
		Vector2(8, 4),
		Vector2(0, 8)
	]
	draw_polygon(points, [Global.colour02])
	
	if boost_active:
		var boost_flame_r = [
			Vector2(1, 4),
			Vector2(6, 12),
			Vector2(8, 4),
		]
		var boost_flame_l = [
			Vector2(-1, 4),
			Vector2(-6, 12),
			Vector2(-8, 4),
		]
		draw_polygon(boost_flame_r, [Global.colour02])
		draw_polygon(boost_flame_l, [Global.colour02])
	
func shoot() -> void:
	var proj = Projectile.instantiate()
	proj.global_position = $Muzzle.global_position
	proj.rotation = rotation
	get_parent().add_child(proj)
	if not audio_shot.playing:
		audio_shot.play()

func get_hit() -> void:
	if is_instance_valid(Global.player_instance):
		game.player_instance.queue_free()
		Global.lives -= 1


func set_boost_active(active: bool) -> void:
	boost_active = active
	queue_redraw()
