extends Control
class_name Inventory_UI

@onready var father = self.owner
@onready var inventory : Inventory =  self.owner.inventory

@onready var ItemStackUIClass = preload("res://Inventory/panel_UI.tscn")
@onready var hotbar_slots : Array = $"../Hotbar".slots
@onready var slots : Array = hotbar_slots + $NinePatchRect/GridContainer.get_children()

var item_in_hand : Item_Stack_UI
var oldIndex: int = -1
var locked = false


func _ready():
	connect_inventory()

func connect_inventory():
	connect_Slots()
	inventory.updated.connect(update)
	update()

func connect_Slots():
	for i in range(slots.size()):
		var slot = slots[i]
		slot.index = i
		
		var callable = Callable(on_Slot_Clicked)
		callable = callable.bind(slot)
		slot.pressed.connect(callable)

func update():
	for i in range(min(inventory.slots.size(), slots.size())):
		var inventorySlot : Inv_Slot = inventory.slots[i]
		
		if !inventorySlot.item: 
			var slot = slots[i]
			if not slot.is_empty():
				slot.erase_item()
			continue
		
		var itemstackui : Item_Stack_UI = slots[i].item_stack_ui
		if !itemstackui:
			itemstackui = ItemStackUIClass.instantiate()
			slots[i].insert(itemstackui)
		
		itemstackui.inventoryslot = inventorySlot
		itemstackui.update()

func on_Slot_Clicked(slot):
	if locked: return
	
	if slot.is_empty():
		if !item_in_hand: return
		
		insert_item_in_slot(slot)
		return
	
	if !item_in_hand:
		take_item_from_slot(slot)
		return
	
	if slot.item_stack_ui.inventoryslot.item.name == item_in_hand.inventoryslot.item.name:
		stack_items(slot)
		return
	
	swap_items(slot)

func take_item_from_slot(slot):
	item_in_hand = slot.take_item()
	add_child(item_in_hand)
	update_itemInHand()
	
	oldIndex = slot.index

func insert_item_in_slot(slot):
	var item = item_in_hand
	
	remove_child(item_in_hand)
	item_in_hand = null
	
	slot.insert(item)
	
	oldIndex = -1

func swap_items(slot):
	var tempItem = slot.take_item()
	
	insert_item_in_slot(slot)
	
	item_in_hand = tempItem
	add_child(item_in_hand)
	update_itemInHand()

func stack_items(slot):
	var slot_item : Item_Stack_UI = slot.item_stack_ui
	var maxAmount = slot_item.inventoryslot.item.stack
	var totalAmount = slot_item.inventoryslot.amount + item_in_hand.inventoryslot.amount
	
	if slot_item.inventoryslot.amount == maxAmount:
		swap_items(slot)
		return
	
	if totalAmount <= maxAmount:
		slot_item.inventoryslot.amount = totalAmount
		remove_child(item_in_hand)
		item_in_hand = null
		oldIndex = -1
	
	else:
		slot_item.inventoryslot.amount = maxAmount
		item_in_hand.inventoryslot.amount = totalAmount - maxAmount
	
	slot_item.update()
	if item_in_hand: item_in_hand.update()

func update_itemInHand():
	if !item_in_hand: return
	item_in_hand.global_position = get_global_mouse_position() - item_in_hand.size / 2

func put_item_back():
	locked = true
	if oldIndex < 0:
		var emptySlots = slots.filter(func (s): return s.is_empty())
		if emptySlots.is_empty() : return
		
		oldIndex = emptySlots[0].index
		
	var targetSlot = slots[oldIndex]
	
	var tween = create_tween()
	if tween:
		var targetPosition = targetSlot.global_position + targetSlot.size / 2
		tween.tween_property(item_in_hand, "global_position", targetPosition, 0.2)
	
	await tween.finished
	
	insert_item_in_slot(targetSlot)
	locked = false

func right_click():
	if item_in_hand:
		if  locked: return
		put_item_back()
