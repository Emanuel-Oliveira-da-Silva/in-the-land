extends Resource
class_name Inv_Item

@export var name : String = ""
@export var texture : AtlasTexture
@export var stack : int
@export var recipe : Recipe

@export_category("Cooking")
@export var cookable : bool
@export var cook_time : float
@export var Cook_output : Inv_Item

@export_category("Fuel")
@export var is_fuel : bool
@export var fuel: int

func use(player : Player):
	pass
