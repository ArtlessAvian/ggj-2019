extends Area2D

func _on_ToLevel1Dusk_body_entered(body):
	get_tree().change_scene("res://level/Level1-Dusk.tscn")
