extends CharacterBody2D

@export var player_id = 0
@export var SPEED = 200.0
@export var ROT_SPEED = 0.1
@export var initial_position = Vector2(0, 0.5)
@export var initial_ammo = 1

var projectile = preload("res://scenes/projectile.tscn")
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var ammo_left = initial_ammo

func init():
	$AnimatedSprite2D.animation = "p%s" % player_id
	velocity = Vector2.RIGHT * SPEED
	rotation = velocity.angle() + PI / 2
	position = initial_position * get_viewport_rect().size

func hit(points):
	%state.hit(player_id, points)
	
func die():
	hit(10)
	velocity = Vector2.ZERO
	$AudioStreamPlayer2D.play()
	$AnimatedSprite2D.play("die")
	$DieTimeout.start()

func _ready():
	init()

func _physics_process(delta):
	velocity.y += gravity * delta * 0.1
	rotation = velocity.angle() + PI / 2
	
	var direction = Input.get_axis("rotate_left_%s" % player_id, "rotate_right_%s" % player_id)
	if direction:
		velocity = velocity.rotated(ROT_SPEED * direction)
		rotation = velocity.angle() + PI / 2
	
	if Input.is_action_just_pressed("fire_%s" % player_id) and ammo_left > 0:
		var p = projectile.instantiate()
		p.global_position = global_position + -transform.y * 15
		p.rotation = rotation
		get_parent().add_child(p)
		ammo_left -= 1
		$AmmoTimeout.start()

	var vps = get_viewport_rect().size
	position.x = wrapf(position.x, 0, vps.x)
	move_and_slide()



func _on_die_timeout_timeout():
	init()

func _on_ammo_timeout_timeout():
	ammo_left = initial_ammo
