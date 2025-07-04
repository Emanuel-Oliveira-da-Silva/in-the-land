extends Resource
class_name Inv_Item

@export var name : String = ""
@export var texture : AtlasTexture
@export var stack : int
@export var recipe : Recipe

func use(player : Player):
	pass
