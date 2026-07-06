extends Node2D

@onready var pause_menu: Control = $PauseMenu
@onready var level: Node2D = $Level
@onready var resume_button: Button = $PauseMenu/Resume
@onready var menu_button: Button = $PauseMenu/MainMenu
@onready var transition_filter: CanvasLayer = $TransitionFilter

func pause() -> void:
	get_tree().paused = true
	pause_menu.visible = true
	resume_button.grab_focus.call_deferred()
	
func resume() -> void:
	get_tree().paused = false
	pause_menu.visible = false
	
func _ready() -> void:
	var sound_bus: int = AudioServer.get_bus_index("Sound")
	AudioServer.set_bus_mute(sound_bus, not global.sound_on)
	resume()

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		pause()

func _on_resume_button_up() -> void:
	resume()

func _on_main_menu_button_up() -> void:
	transition_filter.reverse = true;
	transition_filter.timer.start();
	await transition_filter.timer.timeout
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

func _on_quit_button_up() -> void:
	transition_filter.reverse = true;
	transition_filter.timer.start();
	await transition_filter.timer.timeout
	get_tree().quit()
