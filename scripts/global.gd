extends Node

var gravity_scale: int = 1
var sound_on: bool
var music_on: bool
var effect_on: bool
var current_level: int
var max_level: int

@warning_ignore("unused_signal")
signal game_over
@warning_ignore("unused_signal")
signal level_cleared

func set_gravity_scale(scale: int) -> void:
	gravity_scale = scale

func _ready() -> void:
	var path: String = String("res://data/game.json")
	if not FileAccess.file_exists(path):
		print("File do not exist")
		return
	var file: FileAccess = FileAccess.open(path, FileAccess.READ)
	var string_data: String = file.get_as_text()
	file.close()
	var game_data: Dictionary = JSON.parse_string(string_data)
	sound_on = bool(game_data["settings"]["sound on"])
	music_on = bool(game_data["settings"]["music on"])
	effect_on = bool(game_data["settings"]["effect on"])
	current_level = int(game_data["progress"]["current level"])

func quit_game() -> void:
	var path: String = String("res://data/game.json")
	if not FileAccess.file_exists(path):
		print("File do not exist")
		return
	var file: FileAccess = FileAccess.open(path, FileAccess.READ_WRITE)
	var string_data: String = file.get_as_text()
	var game_data: Dictionary = JSON.parse_string(string_data)
	game_data["settings"]["sound on"] = sound_on
	game_data["settings"]["music on"] = music_on
	game_data["settings"]["effect on"] = effect_on
	game_data["progress"]["current level"] = current_level
	string_data = JSON.stringify(game_data, "\t")
	file.store_string(string_data)
	file.close()
	get_tree().quit()
