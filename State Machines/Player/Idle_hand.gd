extends StateBase

func unhandled_input(event):
	if Input.is_action_just_pressed("left_click"):
		state_machine.change_to("Hand_Swing")
	
	if Input.is_action_pressed("right_click"):
		state_machine.change_to("Use")
