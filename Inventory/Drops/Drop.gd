extends RigidBody2D

func Body_entered(body):
	body.pick_up("TIERRA!! :D")
	queue_free()
