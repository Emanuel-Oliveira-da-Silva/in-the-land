class_name Player
extends CharacterBody2D


var animations : PlayerAnimations = PlayerAnimations.new()
@onready var movement_state_machine = $Movement_State_Machine2


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

func _process(delta):
	set_facing_direction(velocity.x)
	
	movement_state_machine.process(delta)

func set_facing_direction(x : float):
	if abs(x) > 0:
		$AnimatedSprite2D.scale.x = -1 if (x < 0) else 1

func is_facing_right() -> bool:
	return $AnimatedSprite2D.scale.x > 0

func _unhandled_input(event):
	movement_state_machine.input(event)

func _physics_process(delta):
	movement_state_machine.physics_process(delta)

func play_animation(animation : String):
		$AnimationPlayer.play(animation)
