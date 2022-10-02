extends Label


var score = 0


func _ready() -> void:
	Events.connect("food_collected", self, "on_score_change")


func on_score_change(fruit: RigidBody2D) -> void:
	score += 1 * fruit.mass
	text = str(score)
	# fruit.queue_free()
