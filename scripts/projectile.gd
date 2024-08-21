extends Area2D

var speed = 600
var lifetime = 1.5

func _ready() -> void:
	# to delete the projectile after its lifetime
	await get_tree().create_timer(lifetime).timeout
	queue_free()
	
func _physics_process(delta: float) -> void:
	position += Vector2(0, -speed * delta).rotated(rotation)
		# wrap around screen edges
	if position.x > Game.screenSize.x:
		position.x = 0
	elif position.x < 0:
		position.x = Game.screenSize.x
	if position.y > Game.screenSize.y:
		position.y = 0
	elif position.y < 0:
		position.y = Game.screenSize.y
