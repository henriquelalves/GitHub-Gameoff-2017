extends Node

func get_persistent():
	var p = []
#	p.push_back(get_parent().get_node("Box").get_pos())
	return p

func set_persistent(p):
#	get_parent().get_node("Box").set_pos(p[0])
	pass

func _ready():
	pass
