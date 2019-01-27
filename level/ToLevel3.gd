extends Area2D


func _on_ToLevel3_body_entered(body):
	get_tree().change_scene("res://level/Level3.tscn")
