extends Resource
class_name Inv_Item

@export var name : String = ""
@export var texture : AtlasTexture
@export var stack : int
@export var recipe : Recipe
@export_category("Cooking")
@export var fuel_time : float
@export var cook_time : float
@export var cookable : bool

func use(player : Player):
	pass
