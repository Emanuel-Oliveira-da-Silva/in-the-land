extends StateBase

var wrapper = {"remaining_duration" : null ,"time_acumulator" : 0.0}

func process(delta):
	if controlled_node.tilemap.has_block_on_cursor():
		
		var equipped_item = controlled_node.hotbar.get_equipped_item()
		if equipped_item is Inv_Tool:
			controlled_node.tilemap.scrape_block(wrapper, equipped_item.mining)
			return
		
		controlled_node.tilemap.scrape_block(wrapper, 1)
		return
	wrapper["remaining_duration"] = null
	state_machine.change_to("Hand_Swing")

func unhandled_input(event):
	if Input.is_action_just_released("left_click"):
		wrapper["remaining_duration"] = null
		state_machine.change_to("Hand_Idle")
