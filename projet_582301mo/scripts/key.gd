extends StaticBody2D

@onready var honeybucket: Area2D = $honeybucket

var in_portail_zone = false
var portal_ready = false
var keytaken = false 
var is_collected := false
signal honeybucket_collected

func _ready():
	await get_tree().create_timer(0.5).timeout
	portal_ready = true

func _on_area_2d_body_entered(body):
	if body.name == "Player" and !is_collected:
		is_collected = true
		emit_signal("honeybucket_collected")
