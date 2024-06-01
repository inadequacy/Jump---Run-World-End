extends CharacterBody2D


const speed = 500.0
const jump_power = -2000.0

const acc = 30
const friction = 70

const gravity = 100

const wall_jump_pushback = 700

const wall_slide_gravity = 100
var is_wall_sliding = false

var sounds = []
@onready var audio = $SFX/JumpSound


func _ready():
	sounds.append(load("res://Sounds/jump-1.wav"))
	sounds.append(load("res://Sounds/jump-2.wav"))
	sounds.append(load("res://Sounds/jump-3.wav"))
	sounds.append(load("res://Sounds/jump-4.wav"))
	
	randomize()


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
			_play_random_jump()
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
	

func _play_random_jump():
	var sound_index = randi() % 4
	var sound = sounds[sound_index]
	audio.stream = sound
	audio.play()
