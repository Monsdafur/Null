extends Node2D

enum ButtonType {
	NONE,
	START,
	OPTIONS,
	QUIT,
}

@onready var start_button: Button = $MenuManager/StartButton
@onready var quit_button: Button = $MenuManager/QuitButton
@onready var transition_filter: CanvasLayer = $TransitionFilter

var button_type: ButtonType = ButtonType.NONE
var chosen: bool = false

func _ready() -> void:
	start_button.grab_focus.call_deferred()
	transition_filter.timer.timeout.connect(_on_transition_timeout)
	transition_filter.timer.start()

func _on_start_button_button_up() -> void:
	if chosen:
		return
	chosen = true
	button_type = ButtonType.START
	transition_filter.reverse = true
	transition_filter.timer.start()

func _on_options_button_button_up() -> void:
	if chosen:
		return
	chosen = true
	button_type = ButtonType.OPTIONS
	transition_filter.reverse = true
	transition_filter.timer.start()

func _on_quit_button_button_up() -> void:
	if chosen:
		return
	chosen = true
	button_type = ButtonType.QUIT
	transition_filter.reverse = true
	transition_filter.timer.start()

func _on_transition_timeout() -> void:
	match button_type:
		ButtonType.START:
			get_tree().change_scene_to_file("res://scenes/game.tscn")
		ButtonType.OPTIONS:
			get_tree().change_scene_to_file("res://scenes/option_menu.tscn")
		ButtonType.QUIT:
			global.quit_game()
