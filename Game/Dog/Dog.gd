extends KinematicBody2D

const wander_speed = 100
const move_speed = 300
const move_acc = 1000
var gravity = 640

export (int) var min_x = -100
export (int) var max_x = 100

var grounded = false
var vel = Vector2()

func _ready():
	move_and_collide(Vector2(0,500))

func _physics_process(delta):
	get_input(delta)
	
#	if grounded:
#		if not (test_move(self.global_transform, Vector2(0, 1))):
#			grounded = false
#	else:
#		vel.y += gravity * 3 * delta
	
	vel.x = clamp(vel.x, -move_speed, move_speed)

	self.move_and_slide(vel, Vector2(0, -1))

	if $AnimationPlayer.assigned_animation != "Borf":
		$dogggggg.flip_h = vel.x < 0

	if $AnimationPlayer.assigned_animation == "Walk":
		$AnimationPlayer.advance(abs(vel.x) / 2000) # whee magic numbers

var my_state = "PatrolLeft"
var timer = 5

func get_input(delta):

	
	if (my_state == "PatrolLeft"):
		if (self.position.x < min_x):
			my_state = "PatrolRight"
	elif (my_state == "PatrolRight"):
		if (self.position.x > max_x):
			my_state = "PatrolLeft"
	
	if (my_state == "Chase" or my_state == "Bark"):
		# A frame late but who cares
		$RayCast2D.cast_to = (cat.global_position - self.global_position)
		if $RayCast2D.is_colliding():
			my_state = "PatrolLeft"
	elif (cat != null):
		$RayCast2D.cast_to = (cat.global_position - self.global_position)
		if not $RayCast2D.is_colliding():
			my_state = "Bark"
			timer = 1
			$dogggggg.flip_h = $RayCast2D.cast_to.x < 0
			$AnimationPlayer.play("Borf")
			
	if timer <= 0:
		if (my_state == "Bark"):
			my_state = "Chase"
	timer -= delta

	if (my_state == "PatrolLeft" or my_state == "PatrolRight"):
		if $AnimationPlayer.assigned_animation != "Walk":
			$AnimationPlayer.assigned_animation = "Walk"
		vel.x = 100 * (-1 if my_state == "PatrolLeft" else 1)
	elif (my_state == "Bark"):
		vel.x -= sign(vel.x) * min(abs(vel.x), wander_speed/30)
	elif (my_state == "Chase"):
		if $AnimationPlayer.assigned_animation != "Run":
			$AnimationPlayer.assigned_animation = "Run"
		vel.x += sign(cat.position.x - self.position.x) * move_acc * delta
		

#	if my_state == "Standing":
#		
#	elif my_state == "Wandering":
#		vel.x += 100 * delta * (-1 if my_state == "WanderingLeft" else 1)
#		vel.x = clamp(vel.x, -wander_speed, wander_speed)
#		pass
#
#	if Input.is_action_pressed("ui_left"):
#		vel.x -= delta * move_acc * self.scale.x
#	elif Input.is_action_pressed("ui_right"):
#		vel.x += delta * move_acc * self.scale.x
#	else:
#		if (grounded and $AnimationPlayer.assigned_animation != "Stand"):
#			$AnimationPlayer.play("Stand")
#		vel.x -= sign(vel.x) * min(abs(vel.x), move_speed/10)
#
#	if Input.is_action_just_pressed("ui_jump") and grounded:
#		$AnimationPlayer.play("Jump")
#		grounded = false
#		vel.y = -jump_speed
##		if ($Camera2D.offset.y == 0):
#		$Camera2D.set_pre_jump_y()

var cat = null

func _on_CatDetector_body_entered(body):
	cat = body

func _on_CatDetector_body_exited(body):
	pass
#	my_state = "PatrolRight"
