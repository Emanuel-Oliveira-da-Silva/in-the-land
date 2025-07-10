extends Entity_Bock
class_name Storage_Block

@export var inventory : Inventory

@export var inventory_UI : PackedScene

func interact(body : Player):
	var UI : Inventory_UI= inventory_UI.instantiate()
	UI.inventory = inventory
	body.inventory_UI.add_sibling(UI)
	body.ui_state_machine.change_to("Inventory_open")

func _on_area_2d_body_exited(body : Player):
	for UI in body.canvas_layer.get_children():
		if UI is Barrel_Inventory_UI:
			UI.queue_free()
			return
