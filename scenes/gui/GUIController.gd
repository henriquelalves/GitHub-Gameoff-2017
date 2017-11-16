extends Control

var NPCDialog = preload("res://scenes/gui/NPCDialog.tscn")

onready var current_time = 180.99

func load_dialog(dialog):
	global.set_state(global.STATES.STOP)
	var dialog = NPCDialog.instance()
	add_child(dialog)

func _ready():
	global.gui_controller = self
	set_fixed_process(true)
	pass

func _fixed_process(delta):
	if global.state == global.STATES.PLAY:
		current_time -= delta
		get_node("TimerCounter").set_text("%d:%02d" % [current_time/60,int(current_time)%60])