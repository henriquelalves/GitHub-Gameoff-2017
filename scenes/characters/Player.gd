extends KinematicBody2D

export(float) var vel = 256.0

onready var DIRECTIONS = {
"RIGHT": Vector2(1,0),
"UP": Vector2(0,-1),
"DOWN": Vector2(0,1),
"LEFT": Vector2(-1,0)
}
onready var texture_width = 64

onready var direction = DIRECTIONS["DOWN"]
onready var blinking = false

func set_blinking(b):
	blinking = b
	if b == false:
		get_node("Sprite").show()

func _ready():
	set_fixed_process(true)
	set_process_input(true)
	
	global.player = self

func _input(event):
	if(global.state == global.STATES.PLAY):
		if event.is_action_pressed("ui_accept") and not event.is_echo():
			var space_state = get_world_2d().get_direct_space_state()
			var result = space_state.intersect_ray(get_pos(), get_pos() + direction*(texture_width/2.0 + 2), [self])
			if (not result.empty()):
				if result["collider"].is_in_group("interactables"):
					get_node("AnimationPlayer").stop(true)
					result["collider"].interact()
		if event.is_action_pressed("ui_down"):
			get_node("AnimationPlayer").play("move_down")
		if event.is_action_pressed("ui_left"):
			get_node("AnimationPlayer").play("move_left")
		if event.is_action_pressed("ui_right"):
			get_node("AnimationPlayer").play("move_right")
		if event.is_action_pressed("ui_up"):
			get_node("AnimationPlayer").play("move_up")

func _fixed_process(delta):
	if test_move(Vector2(0.1,0.1)) || test_move(Vector2(-0.1,-0.1)):
		move(Vector2(0,0))
	
	if blinking:
		if not get_node("Sprite").is_visible():
			get_node("Sprite").show()
		else:
			get_node("Sprite").hide()
	
	if global.state == global.STATES.PLAY:
		# Move
		var moving = false
		if Input.is_action_pressed("ui_up"):
			moving = true
			move(Vector2(0.0, -vel*delta))
			direction = DIRECTIONS["UP"]
		if Input.is_action_pressed("ui_down"):
			moving = true
			move(Vector2(0.0, vel*delta))
			direction = DIRECTIONS["DOWN"]
		if Input.is_action_pressed("ui_left"):
			moving = true
			move(Vector2(-vel*delta, 0.0))
			direction = DIRECTIONS["LEFT"]
		if Input.is_action_pressed("ui_right"):
			moving = true
			move(Vector2(vel*delta, 0.0))
			direction = DIRECTIONS["RIGHT"]
		
		if moving and is_colliding():
			if get_collider().is_in_group("pushable"):
				get_collider().move(-get_collision_normal())
		
		if not moving:
			get_node("AnimationPlayer").stop(true)