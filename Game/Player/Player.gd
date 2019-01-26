extends KinematicBody2D


const move_speed = 200
var gravity = 1000
var jump_speed = -500

var vel = Vector2()

func _ready():
	pass

func _physics_process(delta):
	get_input(delta)
	vel.y += gravity * delta
	self.move_and_slide(vel, Vector2(0, -1))

func get_input(delta):
	
	if Input.is_action_pressed("ui_left"):
		vel.x = -move_speed
	elif Input.is_action_pressed("ui_right"):
		vel.x = move_speed
	else:
		vel.x = 0
	
	if Input.is_action_just_pressed("ui_jump") and is_on_floor():
		vel.y = jump_speed










