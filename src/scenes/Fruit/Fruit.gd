extends RigidBody2D


func _on_Fruit_body_entered(body: Node) -> void:
	if body.name == "Player": 
		Events.emit_signal("food_collected", self)


func _ready() -> void:
	$Sprite.texture.region = Rect2(randi() % 37 * 16, randi() % 6 * 16, 16, 16)
