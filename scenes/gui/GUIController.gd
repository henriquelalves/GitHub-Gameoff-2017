extends Control

var NPCDialog = preload("res://scenes/gui/NPCDialog.tscn")

func load_dialog(dialog):
	global.set_state(global.STATES.STOP)
	var dialog = NPCDialog.instance()
	add_child(dialog)

func _ready():
	global.gui_controller = self
	pass
