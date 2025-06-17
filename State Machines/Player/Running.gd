extends Gravity_StateBase

func physics_process(delta):
	controlled_node.play_animation(PlayerAnimations.Run)
	controlled_node.velocity.x = Input.get_axis("left","right") * 300
	
	
	handle_gravity(delta)
	controlled_node.move_and_slide()


func input(event):
	if Input.is_action_pressed("ui_accept"):
		state_machine.change_to("Jumping")
	if Input.get_axis("left","right") == 0:
		state_machine.change_to("Idle")
	elif Input.is_action_just_released("Shift"):
		state_machine.change_to("Walking")
