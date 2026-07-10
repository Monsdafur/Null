extends Area2D

@export var reversed: bool
@export var activation_functions: Array[Callable]
@export var deactivation_functions: Array[Callable]

@onready var sprite: Sprite2D = $Sprite2D
@onready var shape: CollisionShape2D = $CollisionShape2D

var bodies: int = 0

func _ready() -> void:
	sprite.region_rect = Rect2i(16, 480, 16, 16) if not reversed else Rect2i(32, 480, 16, 16)
	shape.position = Vector2(0.0, 6.0) if not reversed else Vector2(0.0, -6.0)

func _on_body_entered(_body: Node2D) -> void:
	bodies += 1
	if not ((reversed and global.gravity_scale == -1) or (not reversed and global.gravity_scale == 1)):
		return
	if bodies > 1:
		return
	sprite.visible = false
	for function: Callable in activation_functions:
		if function.is_valid():
			function.call()

func _on_body_exited(_body: Node2D) -> void:
	bodies -= 1
	if bodies > 0:
		return
	sprite.visible = true
	for function: Callable in deactivation_functions:
		if function.is_valid():
			function.call()
