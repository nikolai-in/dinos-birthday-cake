extends RigidBody2D



func _on_Fruit_body_entered(body: Node) -> void:
	Events.emit_signal("food_collected", self)
