extends KinematicBody2D

var motion = Vector2(0,0)

const SPEED = 500
const GRAVITY = 400
const UP = Vector2(0,-1)
const JUMP_SPEED = 3000

func _physics_process(delta):
	apply_gravity()
	jump()
	move()
	animate()
	move_and_slide(motion, UP)		
	
func apply_gravity():
	if is_on_floor():
		motion.y = 0
	else:
		motion.y += GRAVITY
		
func jump():
	if Input.is_action_pressed("jump") and is_on_floor():
		motion.y -= JUMP_SPEED

func move():
	if Input.is_action_pressed("left") and not Input.is_action_pressed("right"):
		motion.x = -SPEED
	elif Input.is_action_pressed("right") and not Input.is_action_pressed("left"):
		motion.x = SPEED	
	else:
		motion.x = 0

func animate():
	if motion.y < 0:
		$AnimatedSprite.play("jump")
	elif motion.x > 0:
		get_node("AnimatedSprite").set_flip_h(false)
		$AnimatedSprite.play("walk")
	elif motion.x < 0:
		get_node("AnimatedSprite").set_flip_h(true)
		$AnimatedSprite.play("walk")
	else:
		$AnimatedSprite.play("idle")