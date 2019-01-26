extends KinematicBody2D

const move_speed = 200
const move_acc = 6000
var gravity = 640
var jump_speed = 400

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
	
	vel.x = clamp(vel.x, -move_speed, move_speed)
	
	if grounded:
		if not (test_move(self.global_transform, Vector2(0, 1))):
			grounded = false
		
		# Animation is probably walking
		$AnimationPlayer.advance(abs(vel.x) / 1000) # whee magic numbers
		
	else:		
		if (Input.is_action_pressed("ui_jump") and vel.y < 0):
			vel.y += gravity * delta
		else:
			vel.y += gravity * 3 * delta
			
		if is_on_floor():
			grounded = true
			$AnimationPlayer.play("Walk")
			vel.y = 0
		
		if is_on_ceiling():
			vel.y = 0
	
		# Animation is probably jumping
		# Lol do it manually
		$Sprite.frame = clamp(round(vel.y / jump_speed), -1, 1) + 5
	
	self.move_and_slide(vel, Vector2(0, -1))
	if (vel.x != 0):
		$Sprite.flip_h = vel.x < 0

func get_input(delta):
	
	if ((Input.is_action_just_pressed("ui_left") or Input.is_action_just_pressed("ui_right")) and grounded):
		$AnimationPlayer.play("Walk")
	
	if Input.is_action_pressed("ui_left"):
		vel.x -= delta * move_acc
	elif Input.is_action_pressed("ui_right"):
		vel.x += delta * move_acc
	else:
		if (grounded and $AnimationPlayer.assigned_animation != "Stand"):
			$AnimationPlayer.play("Stand")
		vel.x -= sign(vel.x) * min(abs(vel.x), move_speed/10)
	
	if Input.is_action_just_pressed("ui_jump") and grounded:
		$AnimationPlayer.play("Jump")
		grounded = false
		vel.y = -jump_speed

func on_touch_trap():
	if (not self.dead):
		self.dead = true
		self.dead_timer = 0
