extends AnimatableBody2D

@export var p0: Vector2
@export var p1: Vector2
@export var speed: float

var reversed: bool = false

func set_reverse(value: bool) -> void:
	reversed = value

func _ready() -> void:
	position = p0

func _physics_process(delta: float) -> void:
	var dst = p0 if not reversed else p1
	position = position.move_toward(dst, speed * delta)
