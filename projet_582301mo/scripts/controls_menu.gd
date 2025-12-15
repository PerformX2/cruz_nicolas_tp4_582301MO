extends Control
class_name ControlMenu

@onready var exit_button: Button = $MarginContainer/HBoxContainer4/VBoxContainer/exit_button as Button

signal exit_controls_menu

func _ready():
	exit_button.button_down.connect(on_exit_pressed)
	set_process(false)
	
func on_exit_pressed() -> void:
	exit_controls_menu.emit()
	set_process(false)
