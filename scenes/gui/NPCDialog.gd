extends Control

onready var ended = false

func on_animation_finish():
	get_node("TextInterfaceEngine").buff_text("Good to see you Dolores, always glad to share my booze with you. Have you seen Kenny? He looks a little sad.",0.05)
	get_node("TextInterfaceEngine").set_state(1)

func on_break_buff():
	get_node("Arrow").show()

func on_buff_end():
	print("ended")
	ended = true

func _ready():
	get_node("DialogBox").connect("animation_finish", self, "on_animation_finish")
	get_node("DialogBox").animate_yx()
	get_node("TextInterfaceEngine").connect("buff_end", self, "on_buff_end")
	get_node("TextInterfaceEngine").connect("enter_break", self, "on_break_buff")
	get_node("Menu").set_menu(false)
	get_node("Menu").hide()
	get_node("Menu").set_options("Oi\nfuncionou")
	
	set_process_input(true)

func _input(event):
	if event.is_action_pressed("ui_accept") and not event.is_echo():
		if ended:
			global.set_state(global.STATES.PLAY)
			queue_free()
		else:
			get_node("Arrow").hide()