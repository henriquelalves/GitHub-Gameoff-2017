extends Control

onready var Dialog = preload("res://scenes/gui/NPCDialog.tscn")
onready var newDialog = null

func _ready():
	set_process_input(true)
	pass

func _input(event):
	pass