extends KinematicBody2D

enum States {idle, run, jump}
var current_state
var velocity = Vector2()
var UP = Vector2.UP
var speed = 300
var gravity = 600
var max_gravity = 900
var jump_height = 450
var friction = 5.6

func _ready():
	current_state = States.idle

func _physics_process(delta):
	velocity.y += gravity * delta
	if velocity.y > max_gravity:
		velocity.y = max_gravity
	
	# Handle current state logic
	match current_state:
		States.idle:
			Idle(delta)
		States.run:
			Run(delta)
		States.jump:
			Jump(delta)
	
	# Apply movement
	velocity = move_and_slide(velocity, UP)

func Idle(delta):
	$AnimatedSprite.play("idle")
	velocity.x = lerp(velocity.x, 0, friction * delta)

	if Input.is_action_pressed("left") or Input.is_action_pressed("right"):
		current_state = States.run
	elif Input.is_action_just_pressed("jump") and is_on_floor():
		current_state = States.jump

func Run(delta):
	$AnimatedSprite.play("all")

	if Input.is_action_pressed("left"):
		velocity.x = -speed
		$AnimatedSprite.flip_h = true
	elif Input.is_action_pressed("right"):
		velocity.x = speed
		$AnimatedSprite.flip_h = false
	else:
		velocity.x = lerp(velocity.x, 0, friction * delta)
		if abs(velocity.x) < 10:  
			current_state = States.idle

	if Input.is_action_just_pressed("jump") and is_on_floor():
		current_state = States.jump

func Jump(delta):
	if is_on_floor():
		current_state = States.idle 

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = -jump_height
		$AnimatedSprite.play("jump")

	if Input.is_action_pressed("left"):
		velocity.x = -speed
		$AnimatedSprite.flip_h = true
	elif Input.is_action_pressed("right"):
		velocity.x = speed
		$AnimatedSprite.flip_h = false
