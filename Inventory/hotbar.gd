extends Control
class_name Hotbar

@onready var ItemStackUIClass = preload("res://Inventory/panel_UI.tscn")
@onready var inventory : Inventory =  self.owner.inventory
@onready var h_box_container = $HBoxContainer
@onready var slots: Array = $HBoxContainer.get_children()
@onready var selector = $Selector
var equipped_item_index : int =  0


func _ready():
	connect_Slots()
	inventory.updated.connect(update)
	update()

func connect_Slots():
	for i in range(slots.size()):
		var slot = slots[i]
		slot.index = i

var item_in_hand : Item_Stack_UI
var oldIndex: int = -1

func update():
	for i in range(min(inventory.slots.size(), slots.size())):
		var inventorySlot : Inv_Slot = inventory.slots[i]
		
		if !inventorySlot.item:
			var slot : hotbar_slot = slots[i]
			if not slot.is_empty():
				slot.erase_item()
			continue
		
		var itemstackui : Item_Stack_UI = slots[i].item_stack_ui
		if !itemstackui:
			itemstackui = ItemStackUIClass.instantiate()
			slots[i].insert(itemstackui)
		
		itemstackui.inventoryslot = inventorySlot
		itemstackui.update()

func take_item_from_slot(slot):
	item_in_hand = slot.take_item()
	add_child(item_in_hand)
	
	oldIndex = slot.index

func insert_item_in_slot(slot):
	var item = item_in_hand
	
	remove_child(item_in_hand)
	item_in_hand = null
	
	slot.insert(item)
	
	oldIndex = -1

func selector_to_index(index: int):
	equipped_item_index = index
	selector.global_position = slots[index].global_position

func move_selector_to_right():
	equipped_item_index = (equipped_item_index + 1) % slots.size()
	selector.global_position = slots[equipped_item_index].global_position

func move_selector_to_left():
	equipped_item_index = (equipped_item_index - 1 + slots.size()) % slots.size()
	selector.global_position = slots[equipped_item_index].global_position

func get_equipped_item():
	return inventory.slots[equipped_item_index].item
