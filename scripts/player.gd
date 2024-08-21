extends CharacterBody2D

# setup
var speed = 200
var maxSpeed = 420
var rotationSpeed = 3
var brakeSpeed = 120
#var boost_active = false

# apparently I need to preload the textures to change them
#var defaultShip = preload("res://assets/ship.png")
#var boostingShip = preload("res://assets/ship02.png")
#var breakingShip = preload("res://assets/ship03.png")
var Projectile = preload("res://scenes/projectile.tscn")

@onready var ship_vector : Node2D = $ShipVector

#func _ready() -> void:
	#screenSize = get_viewport_rect().size # this will get the screen size when loaded
	#$Sprite2D.texture = defaultShip

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
		#$Sprite2D.texture = boostingShip
		if velocity.length() > maxSpeed:
			velocity = velocity.normalized() * maxSpeed
			#$Sprite2D.texture = defaultShip
	elif Input.is_action_pressed("brake"):
		#$Sprite2D.texture = defaultShip
		# nested ifs this early
		if velocity.length() > 0:
			#$Sprite2D.texture = breakingShip
			velocity = velocity.move_toward(Vector2.ZERO, brakeSpeed * delta)
	else:
		ship_vector.set_boost_active(false)
		#$Sprite2D.texture = defaultShip

	# applyu movement
	move_and_slide()
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
	if position.x > Game.screenSize.x:
		position.x = 0
	elif position.x < 0:
		position.x = Game.screenSize.x
	if position.y > Game.screenSize.y:
		position.y = 0
	elif position.y < 0:
		position.y = Game.screenSize.y
		
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
