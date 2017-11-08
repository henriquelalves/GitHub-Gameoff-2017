extends Control

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	get_node("DialogBox").connect("animation_finish", self, "on_animation_finish")
	get_node("DialogBox").animate_yx()
	get_node("Menu").set_menu(false)
	get_node("Menu").hide()
	pass

func on_animation_finish():
	get_node("Menu").show()
	get_node("Menu").set_menu(true)