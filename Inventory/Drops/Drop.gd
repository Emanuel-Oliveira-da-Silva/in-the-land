extends RigidBody2D

@export var itemRes : Inv_Item

func Body_entered(body):
	if body.has_method("pick_up"):
		body.pick_up(itemRes)
		queue_free()
