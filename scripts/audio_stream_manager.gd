extends Node2D

@onready var activation_sound: AudioStreamPlayer = $ActivationSound
@onready var laser_sound: AudioStreamPlayer = $LaserSound

func stop_all():
	activation_sound.stop()
	laser_sound.stop()	
