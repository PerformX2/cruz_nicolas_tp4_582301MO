extends Control

# This ensures we are targeting the Label you created
@onready var health_label = $HealthLabel

# We use 'value' to avoid the "Shadowed Variable" warning
func update_lives(value: int):
	# Update the text to show "Lives: 3", "Lives: 2", etc.
	if health_label:
		health_label.text = "Lives: " + str(value)
	
	print("HUD Updated: Lives = ", value)
