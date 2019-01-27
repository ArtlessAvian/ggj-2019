extends Area2D

func _on_GoToLevel2_body_entered(body):
	get_tree().change_scene("res://level/Level2.tscn")
