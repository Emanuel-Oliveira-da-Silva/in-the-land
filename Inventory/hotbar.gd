extends HBoxContainer

@onready var ItemStackUIClass = preload("res://Inventory/panel_UI.tscn")
@onready var inventory : Inventory =  self.owner.inventory
@onready var slots: Array = get_children()

var item_in_hand : Item_Stack_UI
var oldIndex: int = -1

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
