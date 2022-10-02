extends Node

export(PackedScene) var fruits_scene

func _ready():
	$AudioStreamPlayer.play()
	randomize()

func _on_FruitTimer_timeout() -> void:
	$FruitTimer.wait_time = rand_range(0.5, 4)
	
	var fruit = fruits_scene.instance()
	var fruit_spawn_location = get_node("FruitPath/SpawnLocation")
	
	fruit_spawn_location.offset = randi()
	
	fruit.position = fruit_spawn_location.position 
	
	add_child(fruit)
