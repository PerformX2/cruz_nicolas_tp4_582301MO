extends Node2D

@onready var start_sfx: AudioStreamPlayer = $start_sfx

func _ready():
	if start_sfx:
		start_sfx.play()
	else:
		print("ERROR: start_sfx Player node not found!")
