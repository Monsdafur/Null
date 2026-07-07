extends Node2D

@onready var transition_filter: CanvasLayer = $TransitionFilter

func change_to_main_menu() -> void:
	transition_filter.reverse = true
	transition_filter.timer.start()
	await transition_filter.timer.timeout
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
