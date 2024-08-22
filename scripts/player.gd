extends RigidBody2D

# setup
@export var speed = 200
@export var max_speed = 420
@export var rotation_speed = 3
@export var brake_speed = 120
@export var shots = 5
@export var boost_active = false
@export var hit_detected = false # trying to prevent multiple collisions per frame
@export var can_shoot = true # to prevent shot abuse

var Projectile = preload("res://scenes/projectile.tscn")

@onready var Game : Node2D = $"/root/Game"

@onready var utils : Node = load("res://scripts/utils.gd").new()

@onready var audio_boost : AudioStreamPlayer2D = $boost
@onready var audio_brake : AudioStreamPlayer2D = $brake
@onready var audio_shot : AudioStreamPlayer2D = $shot
@onready var collision_polygon : CollisionPolygon2D = $Hitbox
@onready var ammo_label : Label = $"/root/Game/HUD/MarginAmmo/AmmoLabel"

func _ready() -> void:
	update_ammo_counter()

func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	hit_detected = false
	### MOVEMENT
	## rotate
	if Input.is_action_pressed("rotate_left"):
		#rotation -= rotationSpeed * delta
		apply_torque_impulse(-rotation_speed * state.step)
	elif Input.is_action_pressed("rotate_right"):
		#rotation += rotationSpeed * delta
		apply_torque_impulse(rotation_speed * state.step)
	else:
		angular_velocity = 0.0
		
	# move
	if Input.is_action_pressed("boost"):
		set_boost_active(true)
		#velocity += Vector2(0, -speed).rotated(rotation) * delta
		apply_central_impulse(Vector2(0, -speed).rotated(rotation) * state.step)
		
		if not audio_boost.playing:
			audio_boost.play()
		
		if linear_velocity.length() > max_speed:
			#velocity = velocity.normalized() * maxSpeed
			linear_velocity = linear_velocity.normalized() * max_speed

	elif Input.is_action_pressed("brake"):
		if not audio_brake.playing:
			audio_brake.play()
		if linear_velocity.length() > 0:
			#velocity = velocity.move_toward(Vector2.ZERO, brakeSpeed * delta)
			linear_velocity = linear_velocity.move_toward(Vector2.ZERO, brake_speed * state.step)
	else:
		set_boost_active(false)

	# applyu movement
	#move_and_slide()
	# get collisions
	for i in range(state.get_contact_count()):
		var collision := state.get_contact_collider_object(i)
		print("Player collided with: ", collision)
		if collision.is_in_group("Asteroids") and not hit_detected:
			hit_detected = true
			#Game.get_hit()
			#var impulse = collision.get_travel() * 100
			#utils.apply_impulse_to_body(body, impulse, rotation)
	
	# wrap around screen edges
	position = utils.wrap_around(position)
		
	# SHOOTING
	if Input.is_action_just_pressed("shoot") and can_shoot:
		shoot()
		
func _draw() -> void:
	var points = [
		Vector2(-8, 4),
		Vector2(0, -12),
		Vector2(8, 4),
		Vector2(0, 8)
	]
	draw_polygon(points, [Global.colour02])
	collision_polygon.polygon = points
	
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
	if shots > 0:
		var proj = Projectile.instantiate()
		get_parent().add_child(proj)
		proj.transform = $Muzzle.global_transform
		proj.rotation = rotation
		audio_shot.play()
		shots -= 1
		update_ammo_counter()
	if shots == 0 and can_shoot:
		can_shoot = false
		reload()

func reload() -> void:
	await get_tree().create_timer(2.0).timeout
	shots = 5
	update_ammo_counter()
	can_shoot = true
	
func set_boost_active(active: bool) -> void:
	boost_active = active
	queue_redraw()

func update_ammo_counter() -> void:
	if shots == 0:
		ammo_label.text = "Ammo: reloading"
	else:
		ammo_label.text = "Ammo: %d" % shots
