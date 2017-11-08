extends Node

enum STATES {
PLAY, STOP
}

onready var gui_controller = null
onready var player = null
onready var state = STATES.PLAY

func set_state(new_state):
	if state != new_state:
		call_deferred("_set_state", new_state)


func _set_state(new_state):
	state = new_state

func _ready():
	pass
