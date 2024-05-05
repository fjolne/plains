extends AnimatableBody2D

const SPEED = 10

func _physics_process(delta):
	transform.origin += -transform.y * SPEED
