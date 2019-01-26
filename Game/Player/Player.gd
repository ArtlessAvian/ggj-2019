extends KinematicBody2D


const move_speed = 200
const gravity = 300

var vel = Vector2()

func _ready():
	pass

func _physics_process(delta):
	if is_on_floor():
		vel.y = 0
	else:
		vel.y += delta * gravity
	
	if Input.is_action_pressed("ui_left"):
		vel.x = -move_speed
	elif Input.is_action_pressed("ui_right"):
		vel.x = move_speed
	else:
		vel.x = 0
	
	self.move_and_slide(vel, Vector2(0, -1))
