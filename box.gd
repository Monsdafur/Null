extends CharacterBody2D

var next_position: float

func  _ready() -> void:
	next_position = floor(position.x / 16.0) * 16.0 + 8.0

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	var tile_position: float = floor(position.x / 16.0) * 16.0 + 8.0
	
	if Input.is_action_pressed("ui_accept"):
		next_position = tile_position + 16.0
	
	position.x = move_toward(position.x, next_position, delta * 60.0)

	move_and_slide()
