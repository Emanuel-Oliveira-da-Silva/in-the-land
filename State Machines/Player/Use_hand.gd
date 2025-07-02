extends StateBase

func start():
	var item : Inv_Item = controlled_node.inventory.slots[controlled_node.hotbar.equipped_item_index].item
	var slot : Inv_Slot = controlled_node.inventory.slots[controlled_node.hotbar.equipped_item_index]
	
	if item:
		item.use(controlled_node)
	
	state_machine.change_to("Hand_Idle")
