extends StateBase

func start():
	controlled_node.hotbar.visible = true
	controlled_node.inventory_UI.locked = true

func unhandled_input(event):
	if Input.is_action_just_pressed("Inventory"):
		controlled_node.inventory_UI.visible = true
		state_machine.change_to("Inventory_open")
	
	elif Input.is_action_just_pressed("ui_cancel"):
		controlled_node.hotbar.visible = false
		controlled_node.pause_menu.visible = true
		state_machine.change_to("Pause_open")

func end():
	controlled_node.inventory_UI.locked = false
