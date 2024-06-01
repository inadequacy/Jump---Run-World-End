extends CharacterBody2D


const speed = 500.0
const jump_power = -2000.0

const acc = 30
const friction = 70

const gravity = 100

const wall_jump_pushback = 700

const wall_slide_gravity = 100
var is_wall_sliding = false

func _physics_process(delta):
	var input_dir: Vector2 = input()
	
	if input_dir != Vector2.ZERO:
		accelerate(input_dir)
	else:
		add_friction()
	player_movement()
	jump()
	wall_slide(delta)
	
func player_movement():
	move_and_slide()

func accelerate(direction):
	velocity = velocity.move_toward(speed * direction, acc)

func add_friction():
	velocity = velocity.move_toward(Vector2.ZERO, friction)

func input() -> Vector2:
	var input_dir = Vector2.ZERO
	
	input_dir.x = Input.get_axis("Left", "Right")
	input_dir = input_dir.normalized()
	return input_dir

func jump():
	if Input.is_action_just_pressed("Jump"):
		if is_on_floor():
			velocity.y = jump_power
		elif is_on_wall_only():
			velocity = Vector2(get_wall_normal().x * wall_jump_pushback, jump_power)
	velocity.y += gravity
	#if Input.is_action_just_pressed("Jump"):
		#if is_on_floor():
			#velocity.y = jump_power
		#if is_on_wall() and Input.is_action_just_pressed("Right"):
			#velocity.y = jump_power
			#velocity.x = -wall_jump_pushback
		#if is_on_wall() and Input.is_action_just_pressed("Left"):
			#velocity.y = jump_power
			#velocity.x = wall_jump_pushback

func wall_slide(delta):
	if is_on_wall_only() and Input.get_axis("ui_left", "ui_right"):  
		velocity.y = min(velocity.y, wall_slide_gravity)
	#if is_on_wall() and !is_on_floor():
		#if Input.is_action_pressed("Left") or Input.is_action_pressed("Right"):
			#is_wall_sliding = true
		#else:
			#is_wall_sliding = false
	#else:
		#is_wall_sliding = false
	#
	#if is_wall_sliding:
		#velocity.y += (wall_slide_gravity * delta)
		#velocity.y = min(velocity.y, wall_slide_gravity)
	#
	
	
	
	
