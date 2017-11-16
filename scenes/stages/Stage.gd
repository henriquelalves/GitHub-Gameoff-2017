extends Control

onready var Dialog = preload("res://scenes/gui/NPCDialog.tscn")
onready var newDialog = null

export(String) var north_stage = ""
export(String) var east_stage = ""
export(String) var south_stage = ""
export(String) var west_stage = ""

func save_persistent():
	if has_node("Persistent"):
		return get_node("Persistent").get_persistent()

func load_persistent(p):
	if has_node("Persistent"):
		get_node("Persistent").set_persistent(p)

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	if global.player == null:
		return
	if (global.state == global.STATES.PLAY):
		if (global.player.get_pos().y <= 52):
			global.global_stage.transition_cardinal(Vector2(global.player.get_pos().x, global.STAGE_HEIGHT-32), Vector2(0,-global.STAGE_HEIGHT+64), north_stage)
		if (global.player.get_pos().y >= global.STAGE_HEIGHT - 20):
			global.global_stage.transition_cardinal(Vector2(global.player.get_pos().x, 32), Vector2(0,global.STAGE_HEIGHT), south_stage)