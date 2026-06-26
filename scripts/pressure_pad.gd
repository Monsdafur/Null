extends Area2D

@export var reversed: bool
@export var activation_function: Callable
@export var deactivation_function: Callable

@onready var sprite: Sprite2D = $Sprite2D
@onready var shape: CollisionShape2D = $CollisionShape2D

var bodies: int = 0

func _ready() -> void:
	sprite.region_rect = Rect2i(Vector2i(0, 8) * 16, Vector2i(16, 16)) if not reversed else Rect2i(Vector2i(2, 8) * 16, Vector2i(16, 16))
	shape.position = Vector2(0.0, 7.0) if not reversed else Vector2(0.0, -7.0)

func _on_body_entered(_body: Node2D) -> void:
	sprite.visible = false
	if activation_function.is_valid():
		activation_function.call()
	bodies += 1

func _on_body_exited(_body: Node2D) -> void:
	bodies -= 1
	if bodies > 0:
		return
	sprite.visible = true
	if deactivation_function.is_valid():
		deactivation_function.call()
