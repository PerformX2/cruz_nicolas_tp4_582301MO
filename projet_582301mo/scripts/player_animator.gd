extends Node2D

@export var player_controller : PlayerController	#variable qui ramène le script associé au joueur (Player)
@export var animation_player : AnimationPlayer   	#variable qui joue une animation(s) nommé(s) et enregistré dans l'onglet animation
@export var sprite : Sprite2D						#variable qui sert à ramener le Sprite2D où il y a les images pour les animations

func _process(_delta):
	#flip le personnage horizontalement dépendament de la direction 
	if player_controller.direction == 1:
		sprite.flip_h = false
	elif player_controller.direction == -1:
		sprite.flip_h = true
	#joue l'animation de marche
	if abs(player_controller.velocity.x) > 0.0:
		animation_player.play("move")
	#joue l'animation "immobile" quand on ne marche plus
	else:
		animation_player.play("idle")
	#joue l'animation d'un saut
	if player_controller.velocity.y < 0.0:
		animation_player.play("jump")
	elif player_controller.velocity.y > 0.0:
		animation_player.play("fall")
		
	
