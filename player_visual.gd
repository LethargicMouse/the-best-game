extends Node2D

const RADIUS = 32
const COLOR = Color.ORANGE_RED

func _draw() -> void:
	draw_circle(Vector2.ZERO, RADIUS, COLOR)
