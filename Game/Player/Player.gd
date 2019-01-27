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
	$Camera2D.pre_jump_y = self.position.y

func _physics_process(delta):
	if ($AnimationPlayer.current_animation == "Fish GET"):
		return
	
	if dead:
		dead_timer += delta
#		print(dead_timer)
		if (dead_timer >= 0.6):
			self.global_position = checkpoint
			$Camera2D.pre_jump_y = checkpoint.y
			self.grounded = false
			dead = false
			self.modulate.a = 1
			vel *= 0
		else:
			self.modulate.a = 1 - dead_timer / 0.5
			vel.y += 10
			self.move_and_slide(vel * self.scale.x, Vector2(0, -1))
			return
	
	else:
		get_input(delta)
	
	vel.x = clamp(vel.x, -move_speed, move_speed)
	
	if grounded:
		if not (test_move(self.global_transform, Vector2(0, 1))):
			grounded = false
			
			$Camera2D.set_pre_jump_y()
		
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
	
	self.move_and_slide(vel * self.scale.x, Vector2(0, -1))
	if (vel.x != 0):
		$Sprite.flip_h = vel.x < 0



func get_input(delta):
	
	if ((Input.is_action_just_pressed("ui_left") or Input.is_action_just_pressed("ui_right")) and grounded):
		$AnimationPlayer.play("Walk")
	
	if Input.is_action_pressed("ui_left"):
		vel.x -= delta * move_acc * self.scale.x
	elif Input.is_action_pressed("ui_right"):
		vel.x += delta * move_acc * self.scale.x
	else:
		if (grounded and $AnimationPlayer.assigned_animation != "Stand"):
			$AnimationPlayer.play("Stand")
		vel.x -= sign(vel.x) * min(abs(vel.x), move_speed/10)
	
	if Input.is_action_just_pressed("ui_jump") and grounded:
		$AnimationPlayer.play("Jump")
		grounded = false
		vel.y = -jump_speed
#		if ($Camera2D.offset.y == 0):
		$Camera2D.set_pre_jump_y()
	
#
func on_touch_trap():
	if (not self.dead):
		self.dead = true
		self.dead_timer = 0
		$AnimationPlayer.play("DONT FEEL SO WELL (HUUUURT)")
		vel.y = -400
		vel.x *= -1
		$Camera2D.set_pre_jump_y()
		grounded = false

func on_touch_fish():
	$AnimationPlayer.play("Fish GET")
