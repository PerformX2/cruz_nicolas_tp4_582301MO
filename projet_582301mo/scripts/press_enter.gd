extends Node2D

@onready var button = $button

func _ready():
	animate_image()

func animate_image():
	var tween = create_tween().set_loops()

	tween.tween_property(button, "scale", Vector2(1.3, 1.3), 0.5)

	tween.tween_property(button, "scale", Vector2(1, 1), 0.5)
