class_name StateMachine
extends Node

@onready var controlled_node = self.owner

@export var default_state : StateBase

@onready var current_state : StateBase = null

func _ready():
	call_deferred("default_start_state")

func default_start_state():
	current_state = default_state
	state_start()

func state_start():
	prints("StateMachine", controlled_node.name, "start state", current_state.name)
	
	current_state.controlled_node = controlled_node
	current_state.state_machine = self
	current_state.start()

func change_to(new_state : String):
	if current_state and current_state.has_method("end") : current_state.end()
	current_state = get_node(new_state)
	state_start()




func process(delta):
	if current_state and current_state.has_method("process"):
		current_state.process(delta)

func physics_process(delta):
	if current_state and current_state.has_method("physics_process"):
		current_state.physics_process(delta)

func input(event):
	if current_state and current_state.has_method("input"):
		current_state.input(event)

func _unhandled_input(event):
	if current_state and current_state.has_method("unhandled_input"):
		current_state.unhandled_input(event)

func _unhandled_key_input(event):
	if current_state and current_state.has_method("unhandled_key_input"):
		current_state.unhandled_key_input(event)
