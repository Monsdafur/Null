extends Node2D

@onready var animated_sprite = $AnimatedSprite2D
@onready var trigger = $Trigger
@onready var area = $Area2D
@onready var activation_timer = $ActivationTimer
@onready var idle_timer = $IdleTimer
var activated: bool

func _ready() -> void:
	activated = false
	area.process_mode = Node.PROCESS_MODE_DISABLED

func _on_trigger_body_entered(_body: Node2D) -> void:
	if activated:
		return
	activation_timer.start()
	print("Trigger activated")

func _on_activation_timer_timeout() -> void:
	activated = true
	area.process_mode = Node.PROCESS_MODE_INHERIT
	animated_sprite.play("activated")
	idle_timer.start()

func _on_area_2d_body_entered(_body: Node2D) -> void:
	global_variables.game_over.emit()

func _on_idle_timer_timeout() -> void:
	animated_sprite.play("retract")
	
func _on_animated_sprite_2d_animation_finished() -> void:
	if not activated:
		return
	area.process_mode = Node.PROCESS_MODE_DISABLED
	activated = false
