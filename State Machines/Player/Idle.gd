extends Gravity_StateBase

func physics_process(delta):
	controlled_node.play_animation(PlayerAnimations.Idle)
	controlled_node.velocity.x = 0
	
	
	handle_gravity(delta)
	controlled_node.move_and_slide()




func input(event):
	if Input.is_action_pressed("ui_accept"):
		state_machine.change_to("Jumping")
	if not Input.get_axis("left","right") == 0:
		if Input.is_action_pressed("Shift"):
			state_machine.change_to("Running")
			return
		
		state_machine.change_to("Walking")
