extends StateBase

func unhandled_input(event):
	if Input.is_action_just_pressed("Inventory") or Input.is_action_just_pressed("ui_cancel"):
		controlled_node.inventory_UI.visible = false
		state_machine.change_to("Inventory_closed")
