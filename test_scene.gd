extends Node2D

@onready var camera = $Camera2D

func _ready() -> void:
	camera.current_room = $Room
