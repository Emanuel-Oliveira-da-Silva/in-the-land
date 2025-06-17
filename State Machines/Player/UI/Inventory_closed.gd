extends StateBase

func unhandled_input(event):
	if Input.is_action_just_pressed("Inventory"):
		controlled_node.inventory_UI.visible = true
		state_machine.change_to("Inventory_open")
	
	elif Input.is_action_just_pressed("ui_cancel"):
		controlled_node.pause_menu.visible = true
		state_machine.change_to("Pause_open")

