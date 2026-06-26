extends CharacterBody2D

@export var p0: Vector2
@export var p1: Vector2
@export var speed: float

var direction: Vector2
var reversed: bool = false
var length: float
var active: bool = true

func set_reverse(value: bool) -> void:
	reversed = value
	active = true
	velocity = direction * speed * (1.0 if not reversed else -1.0)
	print(velocity)

func _ready() -> void:
	position = p1
	direction = (p1 - p0).normalized()
	length = (p1 - p0).length()

func _physics_process(_delta: float) -> void:
	var beg = p0 if not reversed else p1
	var distance = beg.distance_to(position)
	if distance >= length:
		if reversed:
			position = p0
		else:
			position = p1
		active = false
	if not active:
		velocity = Vector2.ZERO
		return
		
	move_and_slide()
