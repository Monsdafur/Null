extends Button

@export var label_text: String = "CHECKBOX"

@onready var state_label: Label = $State
@onready var label: Label = $Label

var checked: bool = true
signal toggle(state: bool)

func set_state(state: bool) -> void:
	checked = state
	state_label.text = "ON" if checked else "OFF"

func _ready() -> void:
	label.text = label_text

func _on_button_up() -> void:
	set_state(not checked)
	toggle.emit(checked)
