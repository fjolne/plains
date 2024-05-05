extends Area2D

const SPEED = 10

func _physics_process(delta):
	transform.origin += -transform.y * SPEED


func _on_body_entered(body):
	$AudioStreamPlayer2D.play()
	$AnimatedSprite2D.play("hit")
	body.hit(1)


func _on_animated_sprite_2d_animation_finished():
	# never called
	print("anim finished")
	queue_free()
