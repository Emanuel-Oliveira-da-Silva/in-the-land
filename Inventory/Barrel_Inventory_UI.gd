extends Control
class_name Storage_UI

var father : Player
var inventory : Inventory

@onready var ItemStackUIClass = preload("res://Inventory/panel_UI.tscn")
@onready var slots : Array = $NinePatchRect/GridContainer.get_children()

var oldIndex: int = -1


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
	
	if slot.is_empty():
		if !father.inventory_UI.item_in_hand: return
		
		insert_item_in_slot(slot)
		return
	
	if !father.inventory_UI.item_in_hand:
		take_item_from_slot(slot)
		return
	
	if slot.item_stack_ui.inventoryslot.item.name == father.inventory_UI.item_in_hand.inventoryslot.item.name:
		stack_items(slot)
		return
	
	swap_items(slot)

func take_item_from_slot(slot):
	father.inventory_UI.item_in_hand = slot.take_item()
	father.inventory_UI.add_child(father.inventory_UI.item_in_hand)
	update_itemInHand()
	
	oldIndex = slot.index

func insert_item_in_slot(slot):
	var item = father.inventory_UI.item_in_hand
	
	father.inventory_UI.remove_child(father.inventory_UI.item_in_hand)
	father.inventory_UI.item_in_hand = null
	
	slot.insert(item)
	
	oldIndex = -1

func swap_items(slot):
	var tempItem = slot.take_item()
	
	insert_item_in_slot(slot)
	
	father.inventory_UI.item_in_hand = tempItem
	father.inventory_UI.add_child(father.inventory_UI.item_in_hand)
	update_itemInHand()

func stack_items(slot):
	var slot_item : Item_Stack_UI = slot.item_stack_ui
	var maxAmount = slot_item.inventoryslot.item.stack
	var totalAmount = slot_item.inventoryslot.amount + father.inventory_UI.item_in_hand.inventoryslot.amount
	
	if slot_item.inventoryslot.amount == maxAmount:
		swap_items(slot)
		return
	
	if totalAmount <= maxAmount:
		slot_item.inventoryslot.amount = totalAmount
		father.inventory_UI.remove_child(father.inventory_UI.item_in_hand)
		father.inventory_UI.item_in_hand = null
		oldIndex = -1
	
	else:
		slot_item.inventoryslot.amount = maxAmount
		father.inventory_UI.item_in_hand.inventoryslot.amount = totalAmount - maxAmount
	
	slot_item.update()
	if father.inventory_UI.item_in_hand: father.inventory_UI.item_in_hand.update()

func update_itemInHand():
	if !father.inventory_UI.item_in_hand: return
	father.inventory_UI.item_in_hand.global_position = get_global_mouse_position() - father.inventory_UI.item_in_hand.size / 2

func put_item_back():
	if oldIndex < 0:
		var emptySlots = slots.filter(func (s): return s.is_empty())
		if emptySlots.is_empty() : return
		
		oldIndex = emptySlots[0].index
		
	var targetSlot = slots[oldIndex]
	
	var tween = create_tween()
	var targetPosition = targetSlot.global_position + targetSlot.size / 2
	tween.tween_property(father.inventory_UI.item_in_hand, "global_position", targetPosition, 0.2)
	
	await tween.finished
	
	insert_item_in_slot(targetSlot)

func right_click():
	if father.inventory_UI.item_in_hand:
		put_item_back()
