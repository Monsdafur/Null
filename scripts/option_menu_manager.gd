extends Node2D

@onready var sound_checkbox: Button = $MenuManager/SoundCheckbox
@onready var effect_checkbox: Button = $MenuManager/WaterEffectCheckbox
@onready var music_checkbox: Button = $MenuManager/MusicCheckbox
@onready var color_limit_checkbox: Button = $MenuManager/ColorLimitCheckbox
@onready var return_button: Button = $MenuManager/Return
@onready var fade_effect: AnimationPlayer = $FadeScreen/AnimationPlayer
@onready var click_sound: AudioStreamPlayer = $ClickSound

var chosen: bool = false

func _ready() -> void:
	sound_checkbox.set_state(global.sound_on)
	effect_checkbox.set_state(global.effect_on)
	music_checkbox.set_state(global.music_on)
	color_limit_checkbox.set_state(global.color_limit)
	sound_checkbox.grab_focus.call_deferred()
	fade_effect.play("fade out")

func _on_sound_checkbox_toggle(state: bool) -> void:
	if not chosen:
		click_sound.play()
		global.sound_on = state

func _on_effect_checkbox_toggle(state: bool) -> void:
	if not chosen:
		click_sound.play()
		global.effect_on = state
		
func _on_music_checkbox_toggle(state: bool) -> void:
	if not chosen:
		click_sound.play()
		global.music_on = state
		
func _on_color_limit_toggle(state: bool) -> void:
	if not chosen:
		click_sound.play()
		global.color_limit = state
	
func _on_return_button_up() -> void:
	if chosen:
		return
	chosen = true
	click_sound.play()
	fade_effect.play("fade in")
	await fade_effect.animation_finished
	global.main_menu_fade = true
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
