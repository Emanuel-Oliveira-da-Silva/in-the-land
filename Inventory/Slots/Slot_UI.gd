extends Button
class_name Slot_UI

@onready var center_container = $CenterContainer

@onready var inventory_UI = $"../../.."


var item_stack_ui : Item_Stack_UI
var index : int

func insert(isg : Item_Stack_UI):
	item_stack_ui = isg
	center_container.add_child(item_stack_ui)
	
	if !item_stack_ui.inventoryslot || inventory_UI.inventory.slots[index] == item_stack_ui.inventoryslot:
		return
	
	inventory_UI.inventory.insert_slot(index, item_stack_ui.inventoryslot)

func take_item():
	var item = item_stack_ui
	
	inventory_UI.inventory.remove_slot(item_stack_ui.inventoryslot)
	
	erase_item()
	
	return item

func erase_item():
	if center_container:
		center_container.remove_child(item_stack_ui)
		item_stack_ui = null

func is_empty():
	return !item_stack_ui
