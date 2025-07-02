extends Panel
class_name Item_Stack_UI

@onready var item_sprite = $item
@onready var label = $Label

var inventoryslot : Inv_Slot

func update():
	if !inventoryslot || !inventoryslot.item: return
	
	$item.texture = inventoryslot.item.texture
	$item.visible = true
	
	if inventoryslot.amount > 1:
		$Label.visible = true
		$Label.text = str(inventoryslot.amount)
	else:
		$Label.visible = false
