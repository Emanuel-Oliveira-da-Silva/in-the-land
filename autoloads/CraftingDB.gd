extends Node


const CRAFTING_lEVELS := [
	preload("res://autoloads/Recipes/Crafting_LVL1.tres"),
	preload("res://autoloads/Recipes/Crafting_LVL2.tres")
]

const COOKING_LEVELS := [
	
]

var crafting_recipes = {}

func ready():
	for lvl in CRAFTING_lEVELS.size():
		crafting_recipes[lvl] = get_recipes_up_to_level(lvl)

func get_recipes_up_to_level(level : int):
	var combined_items : Array[Inv_Item] = []
	for i in range(level + 1):
		combined_items.append_array(CRAFTING_lEVELS[i].items)
	return combined_items
