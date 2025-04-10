class_name Player
extends CharacterBody2D


var animations : PlayerAnimations = PlayerAnimations.new()


#State Machines:
@onready var movement_state_machine = $Movement_State_Machine
@onready var hand_state_machine = $Hand_State_Machine

@onready var tilemap : Tile_Map = $"../TileMap"


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

func _process(delta):
	set_facing_direction(velocity.x)
	
	movement_state_machine.process(delta)
	hand_state_machine.process(delta)

func set_facing_direction(x : float):
	if abs(x) > 0:
		$AnimatedSprite2D.scale.x = -1 if (x < 0) else 1

func is_facing_right() -> bool:
	return $AnimatedSprite2D.scale.x > 0

func _unhandled_input(event):
	movement_state_machine.input(event)
	hand_state_machine.input(event)

func _physics_process(delta):
	movement_state_machine.physics_process(delta)
	hand_state_machine.physics_process(delta)

func play_animation(animation : String):
		$AnimationPlayer.play(animation)

signal cursor_on_block(exists : bool)

func update_cursor_on_block(exists : bool):
	if exists:
		cursor_on_block.emit(true)
		return
	cursor_on_block.emit(false)
