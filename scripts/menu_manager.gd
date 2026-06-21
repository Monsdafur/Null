extends Control

enum ButtonType {
	START,
	QUIT,
}

@onready var start_button: TextureButton = $StartButton
@onready var quit_button: TextureButton = $QuitButton
@onready var timer: Timer = $Timer

var button_type: ButtonType

func _ready() -> void:
	start_button.grab_focus.call_deferred()

func _on_start_button_pressed() -> void:
	button_type = ButtonType.START
	timer.start()

func _on_quit_button_pressed() -> void:
	button_type = ButtonType.QUIT
	timer.start()

func _on_timer_timeout() -> void:
	match button_type:
		ButtonType.START:
			get_tree().change_scene_to_file("res://scenes/game.tscn")
		ButtonType.QUIT:
			get_tree().quit()
			
