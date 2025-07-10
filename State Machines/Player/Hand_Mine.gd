extends StateBase

var wrapper = {"remaining_duration" : null ,"time_acumulator" : 0.0}

func process(delta):
	if controlled_node.tilemap.get_block_on_cursor():
		
		var block = controlled_node.tilemap.get_block_on_cursor()
		var equipped_item = controlled_node.hotbar.get_equipped_item()
		var efficiency : float
		if equipped_item is Inv_Tool:
			efficiency =  equipped_item.mining
		else:
			efficiency = 1.0
		
		if block is Entity_Bock:
			block.start_breaking_block(efficiency)
			return
		else:
			controlled_node.tilemap.scrape_block(wrapper, efficiency)
			return
	wrapper["remaining_duration"] = null
	state_machine.change_to("Hand_Swing")

func unhandled_input(event):
	if Input.is_action_just_released("left_click"):
		wrapper["remaining_duration"] = null
		state_machine.change_to("Hand_Idle")
