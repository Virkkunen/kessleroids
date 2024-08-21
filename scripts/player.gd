extends CharacterBody2D

# setup
var speed = 200
var maxSpeed = 420
var rotationSpeed = 3
var brakeSpeed = 120

# apparently I need to preload the textures to change them
var defaultShip = preload("res://assets/ship.png")
var boostingShip = preload("res://assets/ship02.png")
var breakingShip = preload("res://assets/ship03.png")
var Projectile = preload("res://scenes/projectile.tscn")

func _ready() -> void:
	#screenSize = get_viewport_rect().size # this will get the screen size when loaded
	$Sprite2D.texture = defaultShip

func _physics_process(delta: float) -> void:
	### MOVEMENT
	# rotate
	if Input.is_action_pressed("ui_left"):
		rotation -= rotationSpeed * delta
	elif Input.is_action_pressed("ui_right"):
		rotation += rotationSpeed * delta
		
	# move
	if Input.is_action_pressed("ui_up"):
		velocity += Vector2(0, -speed).rotated(rotation) * delta
		$Sprite2D.texture = boostingShip
		if velocity.length() > maxSpeed:
			velocity = velocity.normalized() * maxSpeed
			$Sprite2D.texture = defaultShip
	elif Input.is_action_pressed("ui_down"):
		$Sprite2D.texture = defaultShip
		# nested ifs this early
		if velocity.length() > 0:
			$Sprite2D.texture = breakingShip
			velocity = velocity.move_toward(Vector2.ZERO, brakeSpeed * delta)
	else:
		$Sprite2D.texture = defaultShip
		
	# applyu movement
	move_and_slide()
	
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
	if Input.is_action_just_pressed("ui_select"):
		shoot()
	
func shoot() -> void:
	var proj = Projectile.instantiate()
	proj.global_position = $Muzzle.global_position
	proj.rotation = rotation
	get_parent().add_child(proj)
