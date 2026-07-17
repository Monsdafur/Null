extends ColorRect

@export var color_stride: int

@onready var raw_pass: SubViewport = $"../RawPass"

func _process(_delta: float) -> void:
	material.set_shader_parameter("albedo", raw_pass.get_texture());
	material.set_shader_parameter("stride", color_stride);
