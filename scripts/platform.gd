extends AnimatableBody2D

class_name Platform
enum Type {
	NONE,
	HORIZONTAL,
	VERTICAL
}

@export var p0: Vector2
@export var p1: Vector2
@export var speed: float
@export var type: Type = Type.NONE


@onready var sprite: Sprite2D = $Sprite2D
@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var bounce_sound: AudioStreamPlayer = $BounceSound

var reversed: bool = false
var active: bool = false

func set_reverse(value: bool) -> void:
	if not (reversed == value):
		active = true
	reversed = value

func _ready() -> void:
	position = p0
	sprite.region_enabled = true
	var shape: RectangleShape2D = RectangleShape2D.new()
	if type == Type.HORIZONTAL:
		shape.size = Vector2(48.0, 16.0)
		sprite.region_rect = Rect2i(0, 80, 48, 16)
	elif type == Type.VERTICAL:
		shape.size = Vector2(16.0, 48.0)
		sprite.region_rect = Rect2i(112, 80, 16, 48)
	collision_shape.shape = shape

func _physics_process(delta: float) -> void:
	var dst = p0 if not reversed else p1
	position = position.move_toward(dst, speed * delta)
	if active and position.distance_squared_to(dst) < 0.025:
		bounce_sound.play()
		active = false
