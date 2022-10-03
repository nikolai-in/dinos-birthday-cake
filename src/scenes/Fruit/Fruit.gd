extends RigidBody2D


func _on_Fruit_body_entered(body: Node) -> void:
	if body.name == "Player": 
		Events.emit_signal("food_collected", self)
		queue_free()


func set_gravity(ungravity_scale: float) -> void:
	self.gravity_scale = ungravity_scale


func _ready() -> void:
	$Sprite.texture.region = Rect2(randi() % 37 * 16, randi() % 6 * 16, 16, 16)
