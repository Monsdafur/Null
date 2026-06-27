extends Node2D

enum State {
	DORMANT,
	ACTIVATING,
	IDLING,
	RETRACT,
}

@export var reversed: bool

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var area: Area2D = $Area2D

var state: State
var dormant_animation: String
var idle_animation: String
var activated_animation: String
var retract_animation: String
var signaled: bool

func activate() -> void:
	state = State.ACTIVATING
	area.process_mode = Node.PROCESS_MODE_INHERIT
	animated_sprite.play(activated_animation)
	
func deactivate() -> void:
	animated_sprite.play(retract_animation)

func _ready() -> void:
	state = State.IDLING
	area.process_mode = Node.PROCESS_MODE_INHERIT
	area.position.y = 2.0 if not reversed else -2.0
	dormant_animation = "dormant" if not reversed else "dormant_inverted"
	idle_animation = "idle" if not reversed else "idle_inverted"
	activated_animation = "activated" if not reversed else "activated_inverted"
	retract_animation = "retract" if not reversed else "retract_inverted"
	animated_sprite.play(idle_animation)
	
func _on_area_2d_body_entered(_body: Node2D) -> void:
	global.game_over.emit()

func _on_animated_sprite_2d_animation_finished() -> void:
	if state == State.ACTIVATING:
		state = State.IDLING
		animated_sprite.play(idle_animation)
	elif state == State.IDLING:
		area.process_mode = Node.PROCESS_MODE_DISABLED
		state = State.DORMANT
		animated_sprite.play(dormant_animation)
