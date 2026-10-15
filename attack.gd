extends Node2D

@onready var anim = $AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	anim.animation_finished.connect(queue_free)
	anim.play("default")
