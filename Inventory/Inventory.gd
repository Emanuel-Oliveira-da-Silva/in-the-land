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

func remove_item(index:int):
	slots[index].amount = slots[index].amount - 1
	print(slots[index].amount)
	if slots[index].amount < 1:
		remove_slot(slots[index])
	updated.emit()

func craft(recipe : Array[Inv_Slot]) -> bool:
	# Paso 1: Verificación
	for required in recipe:
		var total_available := 0
		for slot in slots:
			if slot.item == required.item:
				total_available += slot.amount
		if total_available < required.amount:
			print("No hay suficientes de:", required.item.name)
			return false # Cancelar si no hay suficientes

	# Paso 2: Consumir materiales
	for required in recipe:
		var amount_to_remove := required.amount
		for slot in slots:
			if slot.item == required.item:
				var removed = min(amount_to_remove, slot.amount)
				slot.amount -= removed
				amount_to_remove -= removed
				if slot.amount < 1:
					remove_slot(slot)
				if amount_to_remove < 0:
					break

	updated.emit()
	return true
