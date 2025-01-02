extends State
onready var animated_sprite = $"../../AnimatedSprite"

func start():
	if Input.is_action_just_pressed("left") or Input.is_action_just_pressed("right"):
		current_state = States.run
	pass

func exit():
	if velocity.x == 0:
		current_state = States.idle
	pass

func _process(delta):
	if Input.is_action_pressed("left"):
		velocity.x = -speed
		animated_sprite.play("all")
		animated_sprite.flip_h = true
	elif Input.is_action_pressed("right"):
		velocity.x = speed
		animated_sprite.play("all")
		animated_sprite.flip_h = false
	else:
		velocity.x = lerp(velocity.x, 0, friction * delta)
