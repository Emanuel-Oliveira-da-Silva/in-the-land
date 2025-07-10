extends Inventory_UI
class_name Barrel_Inventory_UI

func _ready():
	slots = $NinePatchRect/GridContainer.get_children()
	connect_Slots()
	inventory.updated.connect(update)
	update()
