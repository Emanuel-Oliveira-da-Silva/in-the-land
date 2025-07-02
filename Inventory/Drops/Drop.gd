extends RigidBody2D
class_name Drop

@export var slotRes: Inv_Slot 

func _on_body_entered(body):
	if body.has_method("pick_up"):
		body.pick_up(slotRes)
		queue_free()
		return

	if body is Drop and body != self:
		if body.slotRes.item != slotRes.item: return
		if self.get_instance_id() < body.get_instance_id():
			slotRes.amount += body.slotRes.amount
			_update_label()
			body.queue_free()

func _update_label():
	if has_node("Label"):
		$Label.text = str(slotRes.amount)
