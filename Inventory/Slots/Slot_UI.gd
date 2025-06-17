extends Panel

@onready var item_sprite = $CenterContainer/Panel/item

func update(item: Inv_Item):
	if !item:
		item_sprite.visible = false
	else:
		item_sprite.visible = true
		item_sprite.texture = item.texture
