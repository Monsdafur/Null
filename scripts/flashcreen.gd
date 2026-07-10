extends Node2D

# The actual main menu or level you want to open after loading
@export_file("*.tscn") var next_scene_path: String = "res://scenes/main_menu.tscn"

@onready var progress_bar: ProgressBar = $Control/ProgressBar

var progress: Array = []
var loading_status: int = 0

func _ready() -> void:
	# Begin background loading the target scene
	ResourceLoader.load_threaded_request(next_scene_path)

func _process(_delta: float) -> void:
	# Check the status of the background loading thread
	loading_status = ResourceLoader.load_threaded_get_status(next_scene_path, progress)
	
	match loading_status:
		ResourceLoader.THREAD_LOAD_IN_PROGRESS:
			# progress[0] returns a float between 0.0 and 1.0. 
			# Multiply by 100 if your ProgressBar's max value is 100.
			progress_bar.value = progress[0] * 100
			
		ResourceLoader.THREAD_LOAD_LOADED:
			progress_bar.value = 100
			# Fetch the loaded scene resource
			var loaded_scene: Resource = ResourceLoader.load_threaded_get(next_scene_path)
			
			# Optional: Add a brief delay or wait for an animation before swapping
			get_tree().change_scene_to_packed(loaded_scene)
			
		ResourceLoader.THREAD_LOAD_FAILED:
			print("Error: Background loading failed.")
