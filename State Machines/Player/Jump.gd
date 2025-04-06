extends Gravity_StateBase

func start():
	controlled_node.velocity.y = -400
	controlled_node.play_animation(PlayerAnimations.Jump)
	

func physics_process(delta):
	handle_gravity(delta)
	controlled_node.move_and_slide()
	if controlled_node.velocity.y > 1:
		state_machine.change_to("Falling")

func handle_gravity(delta):
	controlled_node.velocity.y += gravity * delta
