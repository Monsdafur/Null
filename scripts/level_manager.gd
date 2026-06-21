extends Node2D

@export var level: int
@export var atlas_width: int
@onready var level_layer: TileMapLayer = $LevelLayer
@onready var background_layer: TileMapLayer = $Background
@onready var entrance: Node2D = $Entrance
var ins_pressure_pad: Resource =  preload("res://scenes/pressure_pad.tscn")
var ins_reverse_pressure_pad: Resource =  preload("res://scenes/pressure_pad_reverse.tscn")
var ins_platform: Resource = preload("res://scenes/platform.tscn")
var ins_spike: Resource = preload("res://scenes/spike.tscn")
var ins_reverse_spike: Resource = preload("res://scenes/spike_reverse.tscn")
var ins_player: Resource = preload("res://scenes/player.tscn")

func convert_position(grid_position: Vector2):
	return grid_position * 16.0 + Vector2(8.0, 8.0)

func load_pressure_pad(cell: Dictionary) -> void:
	var reverse: bool
	if int(cell["gid"]) == 32:
		reverse = false
	elif int(cell["gid"]) == 25: 
		reverse = true
	else:
		return
	var pressure_pad: Area2D = ins_pressure_pad.instantiate() if not reverse else ins_reverse_pressure_pad.instantiate()
	var position: Vector2 = Vector2(float(cell["x"]), float(cell["y"]))
	position += Vector2(0.0, 1.0) if reverse else Vector2(0.0, -1.0)
	pressure_pad.position = convert_position(position)
	pressure_pad.z_index = 2
	add_child(pressure_pad)

func load_tilemap(tilemap: TileMapLayer, key: String, json_data: Dictionary) -> void:
	for cell in json_data[key]:
		var position: Vector2i = Vector2i(cell["x"], cell["y"])
		var atlas_position: Vector2i = Vector2i(int(cell["gid"]) % atlas_width, int(cell["gid"]) / atlas_width);
		tilemap.set_cell(position, 0, atlas_position)
		load_pressure_pad(cell)

func _ready() -> void:
	# Json data loading
	var level_file: String = "res://data/levels/level_%d.json" % level
	var file: FileAccess = FileAccess.open(level_file, FileAccess.READ)
	if file == null:
		push_error("Failed to open level file %s" % level_file)
		return
	var text_data: String = file.get_as_text()
	file.close()
	
	var json: JSON = JSON.new()
	var json_data: Dictionary = json.parse_string(text_data)
	
	# Begin loading to tilemap
	load_tilemap(level_layer, "level", json_data)
	load_tilemap(background_layer, "background", json_data)
	
	for pf in json_data["platform"]:
		var platform: AnimatableBody2D = ins_platform.instantiate()
		var p0: Vector2 = convert_position(Vector2(float(pf["x0"]), float(pf["y0"])))
		var p1: Vector2 = convert_position(Vector2(float(pf["x1"]), float(pf["y1"])))
		platform.position = p0
		platform.z_index = 2
		platform.p0 = p0
		platform.p1 = p1
		platform.speed = float(pf["speed"])
		add_child(platform)
		
	for spk in json_data["spike"]:
		var spike: Node2D = ins_spike.instantiate() if spk["gid"] == 11 else ins_reverse_spike.instantiate()
		var position: Vector2 = convert_position(Vector2(float(spk["x"]), float(spk["y"])))
		spike.position = position
		spike.z_index = 1
		add_child(spike)
	
	var entrance: Dictionary = json_data["entrance"]
	if bool(entrance["reverse"]):
		game_manager.gravity_scale = -1.0
	else:
		game_manager.gravity_scale = 1.0
	var player_position: Vector2 = convert_position(Vector2(float(entrance["x"]), float(entrance["y"])))
	var player: CharacterBody2D = ins_player.instantiate()
	get_parent().add_child.call_deferred(player)
	player.global_position = to_global(player_position)
