extends Area2D

export(String) var next_portal = ""

func on_body_enter(body):
	if body == global.player and global.state == global.STATES.PLAY:
		global.global_stage.transition_portal(next_portal)

func _ready():
	connect("body_enter", self, "on_body_enter")
	pass