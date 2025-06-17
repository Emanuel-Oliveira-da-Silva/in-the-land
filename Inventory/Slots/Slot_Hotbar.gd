extends Button
class_name hotbar_slot

@onready var container = $Container


@onready var inventory = $"../.."


var item_stack_ui : Item_Stack_UI
var index : int

func insert(isg : Item_Stack_UI):
	item_stack_ui = isg
	$Container.add_child(item_stack_ui)
	
	if !item_stack_ui.inventoryslot || inventory.inventory.slots[index] == item_stack_ui.inventoryslot:
		return
	
	inventory.inventory.insert_slot(index, item_stack_ui.inventoryslot)

func take_item():
	var item = item_stack_ui
	
	inventory.inventory.remove_slot(item_stack_ui.inventoryslot)
	
	container.remove_child(item_stack_ui)
	item_stack_ui = null
	
	return item

func is_empty():
	return !item_stack_ui
