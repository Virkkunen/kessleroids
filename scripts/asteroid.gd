extends CharacterBody2D

var angular_velocity = 0.2

func _ready():
	add_to_group("Asteroids")

func _physics_process(delta: float) -> void:
	rotation += angular_velocity * delta
	
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
		
