extends RigidBody2D


func _on_Fruit_body_entered(body: Node) -> void:
	Events.emit_signal("food_collected", self)


func _ready() -> void:
	var rng = RandomNumberGenerator.new()
	$Sprite.texture.region = Rect2(16 * rng.randi_range(1,5), 16 * rng.randi_range(1,37), 16, 16)
	$Sprite.rotation_degrees = rand_range(0, 360)
