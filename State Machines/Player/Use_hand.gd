extends StateBase

func start():
	var item : Inv_Item = controlled_node.inventory.slots[controlled_node.hotbar.equipped_item_index].item
	
	if controlled_node.tilemap.get_block_on_cursor() and controlled_node.tilemap.get_block_on_cursor() is Entity_Bock:
		var block : Entity_Bock = controlled_node.tilemap.get_block_on_cursor()
		block.interact(controlled_node)
	
	elif item:
		item.use(controlled_node)
	
	state_machine.change_to("Hand_Idle")
