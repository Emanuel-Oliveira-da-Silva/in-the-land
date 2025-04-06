class_name Gravity_StateBase
extends StateBase

var gravity:float = ProjectSettings.get_setting("physics/2d/default_gravity")


func handle_gravity(delta):
	if not controlled_node.is_on_floor():
		state_machine.change_to("Falling")
	controlled_node.velocity.y += gravity * delta
