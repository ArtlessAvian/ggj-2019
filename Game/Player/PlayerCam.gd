extends Camera2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var pre_jump_y
var camera_smooth_timer

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	if get_parent().grounded:
		self.offset.y -= min(5, self.offset.y)
	else:
		self.offset.y = max(0, pre_jump_y - get_parent().position.y)

func set_pre_jump_y():
	pre_jump_y = get_parent().position.y + self.offset.y
