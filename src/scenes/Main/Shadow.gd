extends Sprite


func _ready() -> void:
	Events.connect("player_moved", self, "move_uder_player")


func move_uder_player(player: KinematicBody2D) -> void:
	position.x = player.position.x
