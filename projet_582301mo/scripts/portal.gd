extends Area2D

# Allows you to select the scene in the Inspector for each level!
@export_file("*.tscn") var next_scene_path : String 
@export var honeybucket_path : NodePath = "../key/honeybucket" # Flexible path

var entered = false
var is_bucket_collected = false

@onready var portal_closed = $portal_closed
@onready var portal_opened = $portal_opened
@onready var sfx_opened = $sfx_portail_opened
@onready var sfx_closed = $sfx_portail_closed

func _ready():
	_update_visuals()

func _process(_delta):
	# Check if the node at that path is gone (collected)
	if has_node(honeybucket_path) == false: 
		is_bucket_collected = true
		_update_visuals()
	
	if entered and Input.is_action_just_pressed("enter_portal"):
		try_enter_portal()

func try_enter_portal():
	if is_bucket_collected:
		sfx_opened.play()
		await sfx_opened.finished
		# Use the exported variable here
		if next_scene_path:
			get_tree().change_scene_to_file(next_scene_path)
		else:
			print("ERROR: No next scene selected in Inspector!")
	else:
		sfx_closed.play()
		print("Collect honey first!")

func _update_visuals():
	portal_closed.visible = !is_bucket_collected
	portal_opened.visible = is_bucket_collected

func _on_body_entered(body):
	if body.name == "Player":
		entered = true

func _on_body_exited(body):
	if body.name == "Player":
		entered = false
