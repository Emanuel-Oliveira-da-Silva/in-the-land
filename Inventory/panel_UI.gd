extends Panel
class_name Item_Stack_UI

@onready var item_sprite = $item
@onready var label = $Label

var inventoryslot : Inv_Slot

func update():
	if !inventoryslot || !inventoryslot.item: return
	
	item_sprite.texture = inventoryslot.item.texture
	item_sprite.visible = true
	
	if inventoryslot.amount > 1:
		label.visible = true
		label.text = str(inventoryslot.amount)
	else:
		label.visible = false
