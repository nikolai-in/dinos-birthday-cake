extends State
"""
Parent state that abstracts and handles basic movement
Move-related children states can delegate movement to it, or use its utility functions
"""

export var max_speed_default: = Vector2(500.0, 1500.0)
export var acceleration_default: = Vector2(100000, 3000.0)
export var jump_impulse: = 900.0

var acceleration: = acceleration_default
var max_speed: = max_speed_default
var velocity: = Vector2.ZERO


func flip_sprite(move_direction: Vector2) -> void:
	if move_direction.x < 0:
		$"%AnimatedSprite".flip_h = true
	else: 
		$"%AnimatedSprite".flip_h = false


func unhandled_input(event: InputEvent) -> void:
	if owner.is_on_floor() and (event.is_action_pressed("jump") or event.device == -1):
		_state_machine.transition_to("Move/Air", { impulse = jump_impulse })

func physics_process(delta: float) -> void:
	velocity = calculate_velocity(velocity, max_speed, acceleration, delta, get_move_direction())
	velocity = owner.move_and_slide(velocity, owner.FLOOR_NORMAL)
	Events.emit_signal("player_moved", owner)
	flip_sprite(get_move_direction())
	
	if Input.get_accelerometer().y < 0:
		get_tree().call_group("fruits", "set_gravity", -20)
	elif Input.get_accelerometer().y > 0:
		get_tree().call_group("fruits", "set_gravity", 9)
		


static func calculate_velocity(
		old_velocity: Vector2,
		max_speed: Vector2,
		acceleration: Vector2,
		delta: float,
		move_direction: Vector2
	) -> Vector2:
	var new_velocity: = old_velocity

	new_velocity += move_direction * acceleration * delta
	new_velocity.x = clamp(new_velocity.x, -max_speed.x, max_speed.x)
	new_velocity.y = clamp(new_velocity.y, -max_speed.y, max_speed.y)
	
	
	return new_velocity


static func get_move_direction() -> Vector2:
	if Input.get_accelerometer() == Vector3.ZERO:
		return Vector2(
			Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
			1.0
		)
	else:
		return Vector2(-Input.get_accelerometer().x, 1.0)
