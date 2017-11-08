extends KinematicBody2D

export(float) var vel = 4.0

onready var DIRECTIONS = {
"RIGHT": Vector2(1,0),
"UP": Vector2(0,-1),
"DOWN": Vector2(0,1),
"LEFT": Vector2(-1,0)
}
onready var texture_width = get_node("Sprite").get_texture().get_width()

onready var direction = DIRECTIONS["DOWN"]

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
					result["collider"].interact()

func _fixed_process(delta):
	if global.state == global.STATES.PLAY:
		# Move
		if Input.is_action_pressed("ui_up"):
			move(Vector2(0.0, -vel))
			direction = DIRECTIONS["UP"]
		if Input.is_action_pressed("ui_down"):
			move(Vector2(0.0, vel))
			direction = DIRECTIONS["DOWN"]
		if Input.is_action_pressed("ui_left"):
			move(Vector2(-vel, 0.0))
			direction = DIRECTIONS["LEFT"]
		if Input.is_action_pressed("ui_right"):
			move(Vector2(vel, 0.0))
			direction = DIRECTIONS["RIGHT"]