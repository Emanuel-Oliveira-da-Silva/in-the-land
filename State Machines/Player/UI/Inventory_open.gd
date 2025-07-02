extends StateBase

func unhandled_input(event):
	if Input.is_action_just_pressed("Inventory") or Input.is_action_just_pressed("ui_cancel"):
		controlled_node.inventory_UI.put_item_back()
		controlled_node.inventory_UI.visible = false
		controlled_node.crafting_menu.visible = false
		state_machine.change_to("Inventory_closed")
	
	if Input.is_action_just_pressed("ui_down"):
		controlled_node.crafting_menu.next_item()
	elif Input.is_action_just_pressed("ui_up"):
		controlled_node.crafting_menu.prev_item()
		

func process(delta):
	controlled_node.inventory_UI.update_itemInHand()
	if Input.is_action_just_pressed("right_click"):
		controlled_node.inventory_UI.right_click()
