extends Control

@onready var player : Player = self.owner
@onready var inventory : Inventory =  self.owner.inventory
@onready var recipes : Array[Inv_Item] = player.recipes

var item_stack_ui_class = preload("res://Inventory/panel_UI.tscn")

var selected_item_index : int = 1

@onready var select = $Select
@onready var top = $Top
@onready var bottom = $Bottom
@onready var h_box_container = $HBoxContainer

func _ready():
	recipes = player.recipes
	update()

func update():
	select.icon = recipes[selected_item_index].texture
	top.icon = recipes[(selected_item_index - 1 + recipes.size()) % recipes.size()].texture
	bottom.icon = recipes[(selected_item_index + 1) % recipes.size()].texture
	for panel in h_box_container.get_children():
		h_box_container.remove_child(panel)
	
	if recipes[selected_item_index].recipe:
		for slot : Inv_Slot in recipes[selected_item_index].recipe.inputs:
			var itemstackui : Item_Stack_UI
			itemstackui = item_stack_ui_class.instantiate()
			itemstackui.inventoryslot = slot
			itemstackui.update()
			itemstackui.size = Vector2i(40,40)
			h_box_container.add_child(itemstackui)


func next_item():
	selected_item_index = (selected_item_index + 1) % recipes.size()
	update()

func prev_item():
	selected_item_index = (selected_item_index - 1 + recipes.size()) % recipes.size()
	update()

func craft():
	if recipes[selected_item_index].recipe:
		if inventory.craft(recipes[selected_item_index].recipe.inputs):
			for item in recipes[selected_item_index].recipe.output_Quantity:
				inventory.insert(recipes[selected_item_index])
