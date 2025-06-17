extends Button

@onready var center_container = $CenterContainer

var item_stack_ui : Item_Stack_UI

func insert(isg : Item_Stack_UI):
	item_stack_ui = isg
	center_container.add_child(item_stack_ui)
