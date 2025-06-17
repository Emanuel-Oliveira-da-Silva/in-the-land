extends Control

@onready var father = self.owner

@onready var inventory : Inventory =  self.owner.inventory
@onready var slots : Array = $NinePatchRect/GridContainer.get_children()

func _ready():
	inventory.updated.connect(update())
	update()

func update():
	for i in range(min(inventory.slots.size(), slots.size())):
		slots[i].update(inventory.slots[i])
