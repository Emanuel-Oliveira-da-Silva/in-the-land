extends StateBase

var wrapper = {"remaining_duration" : null ,"time_acumulator" : 0.0}

func cursor_on_block(exists : bool):
	if exists:
		controlled_node.tilemap.scrape_block(wrapper)
		return
	#Restore_Block
	state_machine.change_to("Hand_Swing")

func unhandled_input(event):
	if Input.is_action_just_released("left_click"):
		#Restore_Block
		state_machine.change_to("Hand_Idle")
