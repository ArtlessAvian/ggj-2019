extends Area2D

var collected = false

func _ready():
	$Particles2D.process_material.initial_velocity = 8000

func _on_Fish_body_entered(body):
	if (not collected and body.name == "Player"):
		$AnimationPlayer.play("collected")
#		$Particles2D.emitting = true
		collected = true
		body.on_touch_fish()
