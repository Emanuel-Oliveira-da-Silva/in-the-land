extends Resource

class_name Inventory

signal updated

@export var slots : Array[Inv_Slot]

func insert(item : Inv_Item):
	var itemSlots : Array[Inv_Slot] = slots.filter(func(slot : Inv_Slot): return slot.item == item)
	if !itemSlots.is_empty():
		itemSlots[0].amount += 1
	else:
		var emptySlots : Array[Inv_Slot] = slots.filter(func(slot : Inv_Slot): return slot.item == null)
		if !emptySlots.is_empty():
			emptySlots[0].item = item
			emptySlots[0].amount = 1
	
	updated.emit()
