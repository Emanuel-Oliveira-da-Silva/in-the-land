extends StateBase

func start():
	#play animation(Swing)
	pass

var durability : float

func cursor_on_block(exists : bool):
	if exists:
		state_machine.change_to("Mine")

func unhandled_input(event):
	if Input.is_action_just_released("left_click"):
		state_machine.change_to("Hand_Idle")
