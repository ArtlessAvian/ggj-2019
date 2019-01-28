extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	pass
	

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_area2d_body_entered(body):
	$Timer.start()
	$Sprite.show()
	$EndingText.show()


func _on_Timer_timeout():
	get_tree().change_scene("res://level/Credits1.tscn")
