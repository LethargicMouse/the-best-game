extends CharacterBody2D

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D

const SPEED = 300.0
const JUMP_VELOCITY = -1000.0
var timer = 0
var timer_2 = 0

func _ready() -> void:
	anim.play("idle")

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("ui_accept"):
		timer_2 = 0
	if is_on_floor():
		timer = 0
		if timer_2 <= 0.2:
			velocity.y = JUMP_VELOCITY
	if Input.is_action_just_released("ui_accept") and velocity.y < 0:
		velocity.y *= 0.35
	timer += delta
	timer_2 += delta

	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	if direction != 0.0:
		anim.flip_h = direction < 0.0

	move_and_slide()

	#if not is_on_floor():
		#if velocity.y < 0.0:
			#anim.play("jump")
		#else:
			#anim.play("fall")
	#elif abs(velocity.x) > 10.0:
		#anim.play("run")
	#else:
