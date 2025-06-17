extends Resource

class_name Inventory

signal updated

@export var slots : Array[Inv_Slot]

func insert(item : Inv_Item):
	var itemSlots : Array[Inv_Slot] = slots.filter(func(slot : Inv_Slot): return slot.item == item && slot.amount < slot.item.stack)
	if !itemSlots.is_empty():
		itemSlots[0].amount += 1
	else:
		var emptySlots : Array[Inv_Slot] = slots.filter(func(slot : Inv_Slot): return slot.item == null)
		if !emptySlots.is_empty():
			emptySlots[0].item = item
			emptySlots[0].amount = 1
	
	updated.emit()

func remove_slot(inventorySlot : Inv_Slot):
	var index = slots.find(inventorySlot)
	if index < 0: return
	
	slots[index] = Inv_Slot.new()
	updated.emit()

func insert_slot(index : int, inv_Slot : Inv_Slot):
	slots[index] = inv_Slot
	updated.emit()

func insert_items(slot : Inv_Slot):
	for i in range(slot.amount):
		insert(slot.item)
	updated.emit()
