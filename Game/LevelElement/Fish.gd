extends Area2D

var collected = false


func _on_Fish_body_entered(body):
	$AnimationPlayer.play("collected")
	collected = true
