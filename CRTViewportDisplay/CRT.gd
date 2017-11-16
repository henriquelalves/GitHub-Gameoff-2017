extends Panel

onready var TweenManager = Tween.new()

func set_scanline(n):
	get_node("CRTShader").get_material().set_shader_param("scan_size", n)

func set_colorbleeding(n):
	get_node("CRTShader").get_material().set_shader_param("bleeding_range_y", n)
	get_node("CRTShader").get_material().set_shader_param("bleeding_range_y", n+1)

func glitch_time():
	TweenManager.interpolate_method(self,"set_scanline", 1, 0, 2, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	TweenManager.interpolate_method(self,"set_colorbleeding", 1, -5, 2, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	TweenManager.interpolate_method(self,"set_scanline", 0, 1, 2, Tween.TRANS_LINEAR, Tween.EASE_OUT,2)
	TweenManager.interpolate_method(self,"set_colorbleeding", -5, 1, 2, Tween.TRANS_LINEAR, Tween.EASE_OUT,2)
	TweenManager.start()

func _ready():
	global.crt = self
	add_child(TweenManager)
	pass
