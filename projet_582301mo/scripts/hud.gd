extends Control

@onready var health_label = $HealthLabel

func update_lives(value: int):
	if health_label:
		health_label.text = "VIES x" + str(value)
	
	print("HUD Updated: VIES x = ", value)
