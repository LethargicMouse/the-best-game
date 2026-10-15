extends Node2D
class_name Room

const HWIDTH = 1000

func _draw() -> void:
	draw_line(Vector2(- HWIDTH, -500), Vector2(- HWIDTH, 500), Color.WHITE)
	draw_line(Vector2(+ HWIDTH, -500), Vector2(+ HWIDTH, 500), Color.WHITE)
