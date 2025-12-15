extends Area2D

@export var damage_amount = 1

func _on_body_entered(body):
	# On vérifie si c'est le PlayerController
	if body is PlayerController:
		body.take_damage(damage_amount)
