extends StaticBody2D
class_name Entity_Bock

@export var hardness : float

var mining : float

@onready var full_hardness : float = hardness

@export var drop : PackedScene

@onready var break_timer = $BreakTimer

var is_breaking : bool = false

func _on_input_event(viewport, event, shape_idx):
	if Input.is_action_just_released("left_click"):
		stop_breaking_block()

func interact(body):
	print("INTERACT!!")

func start_breaking_block(efficiency):
	if not is_breaking:
		is_breaking = true
		break_timer.start()
		mining = efficiency

func stop_breaking_block():
	is_breaking = false
	break_timer.stop()
	hardness = full_hardness


func _on_break_timer_timeout():
	hardness -= mining
	print("Current Hardness: ", hardness)
	if hardness <= 0:
		break_block()
		mining = 1

func break_block():
	if drop:
		var new_drop = drop.instantiate()
		new_drop.global_position = self.global_position
		self.add_sibling(new_drop)
	queue_free()


func _on_mouse_exited():
	stop_breaking_block()
