extends Camera2D

@export var target: Node2D
@export var floor: Node2D
const BOX = Vector2(25, 25)
const SMOOTH = 5
const MOVING = true
const PAD = 500
var box_point: Vector2
var real_pos: Vector2

func _process(delta: float) -> void:
	var relative := target.global_position - real_pos
	var rel_abs := relative.abs()
	if MOVING and (rel_abs.x > BOX.x or rel_abs.y > BOX.y):
		var t: float = min(BOX.x / rel_abs.x, BOX.y / rel_abs.y)
		box_point = real_pos + t * relative
		real_pos += (target.global_position - box_point) * SMOOTH * delta
		global_position = real_pos
		if global_position.y > floor.global_position.y - PAD:
			global_position.y = floor.global_position.y - PAD
		queue_redraw()
	else:
		box_point = Vector2.ZERO

func _draw() -> void:
	const filled = false
	draw_rect(Rect2(real_pos - global_position - BOX, BOX * 2), Color.DARK_RED, filled)
	if box_point != Vector2.ZERO:
		draw_circle(box_point - global_position, 5, Color.DARK_ORANGE)
