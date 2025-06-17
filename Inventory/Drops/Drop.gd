extends RigidBody2D

@export var slotRes : Inv_Slot = Inv_Slot.new()

func Body_entered(body):
	if body.has_method("pick_up"):
		body.pick_up(slotRes)
		queue_free()
