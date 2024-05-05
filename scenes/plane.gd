extends CharacterBody2D


const SPEED = 200.0
const ROT_SPEED = 0.1
const JUMP_VELOCITY = -400.0

var projectile = preload("res://scenes/projectile.tscn")

func _ready():
	velocity = Vector2.RIGHT * SPEED
	rotation = velocity.angle() + PI / 2

func _physics_process(delta):
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity = velocity.rotated(ROT_SPEED * direction)
		rotation = velocity.angle() + PI / 2
	
	if Input.is_action_just_pressed("ui_accept"):
		var p = projectile.instantiate()
		p.global_position = global_position + -transform.y * 15
		p.rotation = rotation
		get_parent().add_child(p)

	position = position.posmodv(get_viewport_rect().size)

	move_and_slide()
