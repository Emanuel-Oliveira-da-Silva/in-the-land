extends Control

@onready var father = self.owner
@onready var inventory : Inventory =  self.owner.inventory

@onready var ItemStackUIClass = preload("res://Inventory/panel_UI.tscn")
@onready var slots : Array = $NinePatchRect/GridContainer.get_children()

func _ready():
	connect_Slots()
	inventory.updated.connect(update)
	update()

func connect_Slots():
	for slot in slots:
		var callable = Callable(on_Slot_Clicked)
		callable = callable.bind(slot)
		slot.pressed.connect(callable)

func update():
	for i in range(min(inventory.slots.size(), slots.size())):
		var inventorySlot : Inv_Slot = inventory.slots[i]
		
		if !inventorySlot.item: continue
		
		var itemstackui : Item_Stack_UI = slots[i].item_stack_ui
		if !itemstackui:
			itemstackui = ItemStackUIClass.instantiate()
			slots[i].insert(itemstackui)
		
		itemstackui.inventoryslot = inventorySlot
		itemstackui.update()

func on_Slot_Clicked(slot):
	print("ME CLICKEARON")
	pass
