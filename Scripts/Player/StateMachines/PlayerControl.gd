extends Node

@onready var player:Player = self.owner


@onready var movement_state_machine = $"."

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

enum STATE {
	IDLE,
	RUNING,
	JUMPING,
	CAST
}

var current_state:STATE = STATE.IDLE

func _unhandled_input(event):
	
