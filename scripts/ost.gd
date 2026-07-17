extends AudioStreamPlayer

func _process(_delta: float) -> void:
	var music_bus: int = AudioServer.get_bus_index("Music")
	AudioServer.set_bus_mute(music_bus, not global.music_on)
