extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func interact():
	global.gui_controller.load_dialog("OI")

func _ready():
	add_to_group("interactables")
