extends Area2D

func _on_body_entered(body):
	if is_instance_of(body, CharacterBody2D):
		body.die()
