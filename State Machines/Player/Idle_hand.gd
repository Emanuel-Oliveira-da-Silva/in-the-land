extends StateBase

func unhandled_input(event):
	if Input.is_action_just_pressed("left_click"):
		state_machine.change_to("Hand_Swing")
