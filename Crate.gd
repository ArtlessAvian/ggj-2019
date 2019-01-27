extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var grounded = false
var y_vel = 0

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
#	if (grounded):
#		if (test_move(self.transform, Vector2(0, 1))):
#			grounded = false
#
#	if (not grounded):
	y_vel += 60000 * delta
	self.move_and_slide(Vector2(0, y_vel * delta), Vector2(0, -1))

	if self.is_on_floor():
#		grounded = true
		y_vel = 0

	# Called every frame. Delta is time since last frame.
	# Update game logic here.
#	pass
