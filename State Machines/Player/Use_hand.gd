extends StateBase

func start():
	var item : Inv_Item = controlled_node.inventory.slots[controlled_node.hotbar.equipped_item_index].item
	var slot : Inv_Slot = controlled_node.inventory.slots[controlled_node.hotbar.equipped_item_index]
	
	if item is Inv_Block:
		var atlas_coords : Vector2i = item.Atlas_coord
		var Source_ID : int = item.Source_ID
		
		controlled_node.tilemap.place_block(Source_ID,atlas_coords)
	state_machine.change_to("Hand_Idle")
