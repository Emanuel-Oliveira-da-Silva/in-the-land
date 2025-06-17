extends Button

@onready var item_sprite = $CenterContainer/Panel/item
@onready var label = $CenterContainer/Panel/Label


func update(slot: Inv_Slot):
	if slot.item:
		item_sprite.visible = true
		item_sprite.texture = slot.item.texture
		if slot.amount > 1:
			label.visible = true
			label.text = str(slot.amount)
	else:
		label.visible = false
		item_sprite.visible = false
