extends StateBase

func start():
	for UI in $"../../CanvasLayer".get_children():
		if UI is Storage_UI:
			UI.queue_free()
	controlled_node.hotbar.visible = true
	controlled_node.inventory_UI.locked = true
	controlled_node.inventory_UI.put_item_back()
	controlled_node.inventory_UI.visible = false
	controlled_node.crafting_menu.visible = false

var frame = false

func unhandled_input(event):
	if Input.is_action_just_pressed("Inventory"):
		state_machine.change_to("Inventory_open")
	
	elif Input.is_action_just_pressed("ui_cancel"):
		controlled_node.hotbar.visible = false
		controlled_node.pause_menu.visible = true
		state_machine.change_to("Pause_open")
	
	
	for i in range(5):
		if Input.is_action_just_pressed("Hotbar %d" % (i+1)):
			controlled_node.hotbar.selector_to_index(i)
			break
		
	if Input.is_action_just_pressed("mouse_scroll_up"):
		if frame:
			frame = false
			controlled_node.hotbar.move_selector_to_right()
			return
		frame = true
		
	if Input.is_action_just_pressed("Mouse_scroll_down"):
		if frame:
			frame = false
			controlled_node.hotbar.move_selector_to_left()
			return
		frame = true

func end():
	controlled_node.inventory_UI.locked = false
