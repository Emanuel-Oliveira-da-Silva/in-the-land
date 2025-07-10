extends StateBase

func start():
	#play animation(Swing)
	pass

var durability : float

func process(delta):
	if controlled_node.tilemap.get_block_on_cursor():
		state_machine.change_to("Mine")

func unhandled_input(event):
	if Input.is_action_just_released("left_click"):
		state_machine.change_to("Hand_Idle")
