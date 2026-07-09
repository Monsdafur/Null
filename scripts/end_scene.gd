extends Node2D

@onready var fade_effect: AnimationPlayer = $FadeScreen/AnimationPlayer
@onready var title_effect: AnimationPlayer = $Title/AnimationPlayer
@onready var label_effect: AnimationPlayer = $Control/Label/AnimationPlayer

func _ready() -> void:
	fade_effect.play("fade out")
	await fade_effect.animation_finished
	label_effect.play("fade in")

func change_to_main_menu() -> void:
	global.main_menu_fade = false
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
