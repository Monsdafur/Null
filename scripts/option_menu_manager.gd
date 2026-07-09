extends Node2D

@onready var sound_checkbox: Button = $MenuManager/SoundCheckbox
@onready var effect_checkbox: Button = $MenuManager/WaterEffectCheckbox
@onready var return_button: Button = $MenuManager/Return
@onready var fade_effect: AnimationPlayer = $FadeScreen/AnimationPlayer

func _ready() -> void:
	sound_checkbox.set_state(global.sound_on)
	effect_checkbox.set_state(global.effect_on)
	sound_checkbox.grab_focus.call_deferred()
	fade_effect.play("fade out")

func _on_sound_checkbox_toggle(state: bool) -> void:
	global.sound_on = state

func _on_effect_checkbox_toggle(state: bool) -> void:
	global.effect_on = state
	
func _on_return_button_up() -> void:
	fade_effect.play("fade in")
	await fade_effect.animation_finished
	global.main_menu_fade = true
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
