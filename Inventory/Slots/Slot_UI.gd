extends Button
class_name Slot_UI

@onready var center_container = $CenterContainer

@onready var inventory_UI : Inventory_UI = $"../../.."


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
	
	center_container.remove_child(item_stack_ui)
	item_stack_ui = null
	
	return item

func is_empty():
	return !item_stack_ui
