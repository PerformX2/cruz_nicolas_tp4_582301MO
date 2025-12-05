extends Control
class_name HUD

@export var honeybucket_label : Label
@export var portal_label : Label

func update_honeybucket_label(number : int):
	honeybucket_label.text = "x " + str(number)

func portal_opened():
	portal_label.text = "PORTAL OPENED !"

func portal_closed():
	portal_label.text = "PORTAL CLOSED... COLLECT THE HONEYBUCKET!"
