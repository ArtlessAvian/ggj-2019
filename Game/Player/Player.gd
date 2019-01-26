extends KinematicBody2D

const move_speed = 200
var gravity = 1000
var jump_speed = -500

var grounded = false
var vel = Vector2()

var checkpoint
var dead = false
var dead_timer = 0

func _ready():
	checkpoint = self.global_position

func _physics_process(delta):
	if dead:
		dead_timer += delta
#		print(dead_timer)
		if (dead_timer >= 1):
			self.global_position = checkpoint
			self.grounded = false
			dead = false
		if (grounded):
			vel.x = 0
	
	else:
		get_input(delta)
	
	if not grounded:
		vel.y += gravity * delta
		if is_on_floor():
			grounded = true
			vel.y = 0
	
	self.move_and_slide(vel, Vector2(0, -1))

func get_input(delta):
	
	if Input.is_action_pressed("ui_left"):
		vel.x = -move_speed
	elif Input.is_action_pressed("ui_right"):
		vel.x = move_speed
	else:
		vel.x = 0
	
	if Input.is_action_just_pressed("ui_jump") and grounded:
		grounded = false
		vel.y = jump_speed

func on_touch_trap():
	if (not self.dead):
		self.dead = true
		self.dead_timer = 0
