extends Resource

class_name Inventory

signal updated

@export var slots : Array[Inv_Item]

func insert(item : Inv_Item):
	for i in range(slots.size()):
		if !slots[i]:
			slots[i] = item
			break
			
	updated.emit()
