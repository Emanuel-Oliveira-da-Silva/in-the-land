extends Gravity_StateBase

func physics_process(delta):
	if Input.get_axis("left","right") != 0:
		controlled_node.play_animation(PlayerAnimations.Land_run)
		if Input.is_action_pressed("Shift"):
			state_machine.change_to("Running")
			return
		
		
		state_machine.change_to("Walking")
		return
	
	controlled_node.play_animation(PlayerAnimations.Land)
	state_machine.change_to("Idle")
