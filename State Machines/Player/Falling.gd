extends Gravity_StateBase

func start():
	controlled_node.play_animation(PlayerAnimations.Fall)

func physics_process(delta):
	
	if controlled_node.is_on_floor():
		state_machine.change_to("Landing")
	
	handle_gravity(delta)
	controlled_node.move_and_slide()

func process(delta):
	if Input.get_axis("ui_left","ui_right") != 0:
		controlled_node.velocity.x += Input.get_axis("ui_left","ui_right") * 5


func handle_gravity(delta):
	controlled_node.velocity.y += gravity * delta
