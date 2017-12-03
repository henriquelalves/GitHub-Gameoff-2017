extends KinematicBody2D

# Possible states
enum STATES {
MOVING, AT_BAR, AT_TABLE
}

onready var state = STATES.AT_TABLE

func interact():
	if state == STATES.MOVING:
		return

func _ready():
	call_deferred("_setup")

func _setup():
	if global.gui_controller.current_time < 150.0:
		pass