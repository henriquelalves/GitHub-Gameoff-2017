extends ReferenceFrame

# Such is Life
# by Henrique Alves

# Violets are blue,S
# Cookies are the best,
# Spent a day creating this node script only to discover 24h later that Godot already has a patch9frame node
# But at least the dialog box is working, so that's something I guess.

export(Texture) var frame_texture
export(float) var max_time = 0.6

onready var target_width = get_item_rect().size.x
onready var target_height = get_item_rect().size.y
onready var texture_side = frame_texture.get_width()
onready var frame_side = frame_texture.get_width()/3

onready var sprites = []

onready var tweenManager = Tween.new()
onready var lastTween = Tween.new()

signal animation_finish

func _ready():
	add_child(tweenManager)
	add_child(lastTween)
	
	# Create children
	for y in range(3):
		for x in range(3):
			var sprite = Sprite.new()
			sprite.set_texture(frame_texture)
			sprite.set_hframes(3)
			sprite.set_vframes(3)
			sprite.set_frame(y*3 + x)
			sprite.set_pos(Vector2(-frame_side + x*frame_side, -frame_side + y*frame_side))
			get_node("Center").add_child(sprite)
			sprites.push_back(sprite)
	pass

func animate_yx():
	var final_dist_x = target_width/2 + frame_side/2
	var final_dist_y = target_height/2 + frame_side/2
	var final_scale_x = target_width/frame_side
	var final_scale_y = target_height/frame_side
	
	# y tween
	tweenManager.interpolate_property(sprites[0], "transform/pos", sprites[0].get_pos(), Vector2(-frame_side, -final_dist_y), max_time/2.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tweenManager.interpolate_property(sprites[1], "transform/pos", sprites[1].get_pos(), Vector2(0, -final_dist_y), max_time/2.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tweenManager.interpolate_property(sprites[2], "transform/pos", sprites[2].get_pos(), Vector2(frame_side, -final_dist_y), max_time/2.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tweenManager.interpolate_property(sprites[3], "transform/scale", Vector2(1,1), Vector2(1, final_scale_y), max_time/2.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tweenManager.interpolate_property(sprites[4], "transform/scale", Vector2(1,1), Vector2(1, final_scale_y), max_time/2.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tweenManager.interpolate_property(sprites[5], "transform/scale", Vector2(1,1), Vector2(1, final_scale_y), max_time/2.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tweenManager.interpolate_property(sprites[6], "transform/pos", sprites[6].get_pos(), Vector2(-frame_side, final_dist_y), max_time/2.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tweenManager.interpolate_property(sprites[7], "transform/pos", sprites[7].get_pos(), Vector2(0, final_dist_y), max_time/2.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tweenManager.interpolate_property(sprites[8], "transform/pos", sprites[8].get_pos(), Vector2(frame_side, final_dist_y), max_time/2.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	
	tweenManager.interpolate_property(sprites[0], "transform/pos", Vector2(-frame_side,-final_dist_y), Vector2(-final_dist_x, -final_dist_y), max_time/2.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, max_time/2.0)
	tweenManager.interpolate_property(sprites[1], "transform/scale", Vector2(1,1), Vector2(final_scale_x, 1), max_time/2.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, max_time/2.0)
	tweenManager.interpolate_property(sprites[2], "transform/pos", Vector2(frame_side, -final_dist_y), Vector2(final_dist_x, -final_dist_y), max_time/2.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, max_time/2.0)
	tweenManager.interpolate_property(sprites[3], "transform/pos", Vector2(-frame_side, 0), Vector2(-final_dist_x, 0), max_time/2.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, max_time/2.0)
	tweenManager.interpolate_property(sprites[4], "transform/scale", Vector2(1, final_scale_y), Vector2(final_scale_x, final_scale_y), max_time/2.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, max_time/2.0)
	tweenManager.interpolate_property(sprites[5], "transform/pos", Vector2(frame_side, 0), Vector2(final_dist_x, 0), max_time/2.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, max_time/2.0)
	tweenManager.interpolate_property(sprites[6], "transform/pos", Vector2(-frame_side, final_dist_y), Vector2(-final_dist_x, final_dist_y), max_time/2.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, max_time/2.0)
	tweenManager.interpolate_property(sprites[7], "transform/scale", Vector2(1,1), Vector2(final_scale_x, 1), max_time/2.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, max_time/2.0)
	lastTween.interpolate_property(sprites[8], "transform/pos", Vector2(frame_side, final_dist_y), Vector2(final_dist_x, final_dist_y), max_time/2.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, max_time/2.0)
	
	lastTween.connect("tween_complete",self, "on_tween_complete")
	tweenManager.start()
	lastTween.start()

func on_tween_complete(target, prop):
	emit_signal("animation_finish")