extends Area2D

func _on_GoToLevel0_body_entered(body):
	get_tree().change_scene("res://level/Level0.tscn")
	
