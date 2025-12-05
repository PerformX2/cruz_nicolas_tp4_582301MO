extends Area2D

var entered = false
@onready var honeybucket_node = get_node_or_null("../key/honeybucket")

@onready var portal_closed: Sprite2D = $portal_closed
@onready var portal_opened: Sprite2D = $portal_opened

@onready var sfx_portail_closed: AudioStreamPlayer = $sfx_portail_closed
@onready var sfx_portail_opened: AudioStreamPlayer = $sfx_portail_opened


func _ready():
	# Start with closed portal
	portal_closed.visible = true
	portal_opened.visible = false


func _has_key_been_taken() -> bool:
	return honeybucket_node == null or not is_instance_valid(honeybucket_node)


func _on_body_entered(body):
	if body.name == "Player":
		entered = true
		_update_portal_visibility()


func _on_body_exited(body):
	if body.name == "Player":
		entered = false


func _process(_delta):
	if entered:
		# Keep portal sprite updated in real time
		_update_portal_visibility()

		if Input.is_action_just_pressed("enter_portal"):
			if _has_key_been_taken():
				sfx_portail_opened.play()
				await sfx_portail_opened.finished
				get_tree().change_scene_to_file("res://scenes/zone_3.tscn")
			else:
				sfx_portail_closed.play()
				print("You need the honeybucket to activate this portal!")


func _update_portal_visibility():
	if _has_key_been_taken():
		portal_closed.visible = false
		portal_opened.visible = true
	else:
		portal_closed.visible = true
		portal_opened.visible = false
