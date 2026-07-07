extends CanvasLayer

@export var auto_start: bool = false

@onready var timer: Timer = $Timer
@onready var filter: ColorRect = $ColorRect

var reverse: bool = false

func _ready() -> void:
	if auto_start:
		timer.start()

func _process(_delta: float) -> void:
	var progress = (timer.wait_time - timer.time_left) / timer.wait_time
	if reverse:
		progress = 1.0 - progress
	filter.material.set_shader_parameter("dt", progress)
