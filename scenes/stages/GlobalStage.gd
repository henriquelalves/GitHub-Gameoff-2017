extends Node

onready var TweenManager = Tween.new()
onready var TimerManager = Timer.new()

onready var old_stage = null
onready var new_stage = null
onready var portal_to_pos = Vector2()

func transition_cardinal(player_pos, pos, scene):
	global.persistent_info[get_node("Stage").get_child(0).get_name()] = get_node("Stage").get_child(0).save_persistent()
	
	global.set_state(global.STATES.STOP)
	var new_scene = global.StageLoaders[scene].instance()
	new_scene.set_pos(pos)
	if global.persistent_info.has(new_scene.get_name()):
		new_scene.load_persistent(global.persistent_info[new_scene.get_name()])
	get_node("Stage").add_child(new_scene)
	
	old_stage = get_node("Stage").get_child(0)
	new_stage = get_node("Stage").get_child(1)
	TweenManager.interpolate_property(old_stage, "rect/pos", old_stage.get_pos(), pos*(-1), 1.6, Tween.TRANS_LINEAR, Tween.EASE_IN, 0.5)
	TweenManager.interpolate_property(new_stage, "rect/pos", new_stage.get_pos(), Vector2(0,0), 1.6, Tween.TRANS_LINEAR, Tween.EASE_IN, 0.5)
	TweenManager.interpolate_property(global.player, "transform/pos", global.player.get_pos(), player_pos, 1.6, Tween.TRANS_LINEAR, Tween.EASE_IN, 0.5)
	TweenManager.start()

func transition_portal(portal_to):
	global.persistent_info[get_node("Stage").get_child(0).get_name()] = get_node("Stage").get_child(0).save_persistent()
	
	global.set_state(global.STATES.STOP)
	old_stage = get_node("Stage").get_child(0)
	new_stage = global.StageLoaders[global.portals[portal_to]].instance()
	if global.persistent_info.has(new_stage.get_name()):
		new_stage.load_persistent(global.persistent_info[new_stage.get_name()])
	portal_to_pos = new_stage.get_node(portal_to).get_pos()
	get_node("Stage").add_child(new_stage)
	get_node("Stage").move_child(new_stage, 0)
	TimerManager.set_one_shot(true)
	TimerManager.set_wait_time(1.0)
	global.player.set_blinking(true)
	TimerManager.start()

func on_timeout():
	old_stage.queue_free()
	global.set_state(global.STATES.PLAY)
	global.player.set_blinking(false)
	global.player.set_pos(portal_to_pos)

func on_tween_complete(obj, key):
	if obj == global.player:
		old_stage.queue_free()
		global.set_state(global.STATES.PLAY)

func _ready():
	global.global_stage = self
	add_child(TweenManager)
	add_child(TimerManager)
	TweenManager.connect("tween_complete", self, "on_tween_complete")
	TimerManager.connect("timeout", self, "on_timeout")
	
	global.persistent_info = {}
