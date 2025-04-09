extends StateBase

func start():
	#play animation(Swing)
	pass

func cursor_on_block():
	print("ROMPE ROMPE MIERDA")

func unhandled_input(event):
	if Input.is_action_just_released("left_click"):
		state_machine.change_to("Hand_Idle")
