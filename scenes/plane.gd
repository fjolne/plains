extends CharacterBody2D

@export var player_id = 0
@export var SPEED = 200.0
@export var ROT_SPEED = 0.1

var projectile = preload("res://scenes/projectile.tscn")

func _ready():
	$AnimatedSprite2D.animation = "p%s" % player_id
	velocity = Vector2.RIGHT * SPEED
	rotation = velocity.angle() + PI / 2

func _physics_process(delta):
	var direction = Input.get_axis("rotate_left_%s" % player_id, "rotate_right_%s" % player_id)
	if direction:
		velocity = velocity.rotated(ROT_SPEED * direction)
		rotation = velocity.angle() + PI / 2
	
	if Input.is_action_just_pressed("fire_%s" % player_id):
		var p = projectile.instantiate()
		p.global_position = global_position + -transform.y * 15
		p.rotation = rotation
		get_parent().add_child(p)

	position = position.posmodv(get_viewport_rect().size)

	move_and_slide()
