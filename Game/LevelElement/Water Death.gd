extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	pass


func _on_Trap_body_entered(body):
	if (body.name == "Player"):
		body.on_touch_trap()