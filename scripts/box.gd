extends CharacterBody2D

var is_holding: bool = false

func _physics_process(delta: float) -> void:
	up_direction = Vector2(0, -1) if global.gravity_scale == 1 else Vector2(0, 1)
	
	if not is_on_floor():
		velocity += get_gravity() * global.gravity_scale * delta
	
	if not is_holding:
		velocity.x = 0.0
	
	move_and_slide()
