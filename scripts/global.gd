extends Node

var gravity_scale: int = 1
var sound_on: bool = true
var music_on: bool = true

@warning_ignore("unused_signal")
signal game_over
@warning_ignore("unused_signal")
signal level_cleared

func set_gravity_scale(scale: int) -> void:
	gravity_scale = scale
