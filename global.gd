extends Node

enum STATES {
PLAY, STOP
}

const STAGE_WIDTH = 832
const STAGE_HEIGHT = 640

onready var gui_controller = null
onready var player = null
onready var global_stage = null
onready var crt = null
onready var state = STATES.PLAY

onready var StageLoaders = {
"Test": preload("res://scenes/gui/Test.tscn"),
"Test2": preload("res://scenes/gui/Test2.tscn"),
"Hall": preload("res://scenes/stages/Hall.tscn"),
"Attic": preload("res://scenes/stages/Attic.tscn"),
}

onready var persistent_info = {}

onready var portals = {
"AtticStairs": "Attic",
"HallStairs": "Hall",
}

func set_state(new_state):
	if state != new_state:
		call_deferred("_set_state", new_state)

func _set_state(new_state):
	state = new_state

func _ready():
	randomize()
