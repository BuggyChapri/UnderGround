extends State
onready var animated_sprite = $"../../AnimatedSprite"

func _process(delta):
	animated_sprite.play("idle")
	pass

func start():
	if velocity.x == 0:
		current_state = States.idle
	pass

func exit():
	if velocity.x != 0:
		current_state = States.run
	elif velocity.y != 0:
		current_state = States.jump
	pass
