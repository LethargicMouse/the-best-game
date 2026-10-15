extends CharacterBody2D

@onready var anim = $AnimatedSprite2D

const ATTACK = preload("res://attack.tscn")

const SPEED = 1200.0
const JUMP_VELOCITY = -1200.0
var timer = 0
var timer_2 = 0
var is_attacking = false
var facing = 1

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("jump"):
		timer_2 = 0
	if is_on_floor():
		timer = 0
		if timer_2 <= 0.2:
			velocity.y = JUMP_VELOCITY
	if Input.is_action_just_released("jump") and velocity.y < 0:
		velocity.y *= 0.35
	timer += delta
	timer_2 += delta

	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		facing = sign(direction)
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	if direction != 0.0:
		anim.flip_h = direction < 0.0

	move_and_slide()
	update_anim()

func update_anim():
	if is_attacking:
		return
	if Input.is_action_just_pressed("attack"):
		is_attacking = true
		if velocity.x == 0 or not is_on_floor():
			set_anim("attack")
		await get_tree().create_timer(0.08).timeout
		var effect = ATTACK.instantiate()
		effect.position.y = 60
		effect.scale.x = facing
		effect.tree_exiting.connect(func(): is_attacking = false)
		add_child(effect)
	elif is_on_floor():
		if velocity.x == 0:
			set_anim("idle")
		else:
			set_anim("run")
	else:
		if velocity.y < 0:
			set_anim("jump")
		else:
			set_anim("fall")

func set_anim(new_anim):
	if anim.animation != new_anim:
		anim.play(new_anim)
