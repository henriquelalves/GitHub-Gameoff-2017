extends KinematicBody2D


func _ready():
	add_to_group("pushable")
#	set_fixed_process(true)
#
#func _fixed_process(delta):
#	if is_colliding():
#		print("hola")
#		move(get_collider_velocity()/2)
