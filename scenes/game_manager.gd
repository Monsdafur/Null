extends Node2D

@onready var level: Node2D = $Level

func _ready() -> void:
	global.level_cleared.connect(_on_level_cleared)

func _on_level_cleared() -> void:
	print("WIN")
	pass
