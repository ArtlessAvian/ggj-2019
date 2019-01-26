extends Node

var current

func _ready():
	pass

func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	
	if (current.change_state()):
		current = current.new_state
	
	current.run(delta)
