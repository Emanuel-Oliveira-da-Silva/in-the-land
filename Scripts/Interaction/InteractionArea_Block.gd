extends Interaction_Area
class_name Crafting_Area_Block

@onready var tile_data : TileData

func _on_body_entered(body):
	CraftingManager.register_tile(tile_data)

func _on_body_exited(body):
	print("BYE BYE PLAYEEEEEEEERRR")
	CraftingManager.unregister_tile(tile_data)
