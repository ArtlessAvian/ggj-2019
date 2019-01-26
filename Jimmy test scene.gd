extends KinematicBody2D

var speed = Vector2()

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _physics_process(delta):
	velocity.x += 1
	
