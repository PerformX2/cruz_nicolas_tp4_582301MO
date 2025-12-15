extends Control
class_name MainMenu

@onready var start_button: Button = $MarginContainer/HBoxContainer/VBoxContainer/Start_Button as Button
@onready var exit_button: Button = $MarginContainer/HBoxContainer/VBoxContainer/Exit_Button as Button
@onready var controls_button: Button = $MarginContainer/HBoxContainer/VBoxContainer/Controls_Button as Button
@onready var controls_menu: ControlMenu = $controls_menu
@onready var margin_container: MarginContainer = $MarginContainer

@onready var start_level = preload("res://scenes/zone_1.tscn") as PackedScene

func _ready():
	handle_connecting_signals()
	
func on_start_pressed() -> void:
	get_tree().change_scene_to_packed(start_level)

func on_controls_pressed() -> void:
	margin_container.visible = false
	controls_menu.set_process(true)
	controls_menu.visible = true

func on_exit_pressed() -> void:
	get_tree().quit()
	
func on_exit_controls_menu() -> void:
	margin_container.visible = true
	controls_menu.visible = false

func handle_connecting_signals()-> void:
	start_button.button_down.connect(on_start_pressed)
	controls_button.button_down.connect(on_controls_pressed)
	exit_button.button_down.connect(on_exit_pressed)
	controls_menu.exit_controls_menu.connect(on_exit_controls_menu)
	
