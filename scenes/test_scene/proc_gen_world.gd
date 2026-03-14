extends Node2D

#noise for procedural generation
@export var noise_texture : NoiseTexture2D
var noise : Noise

#map size
var width : int = 100
var height : int = 100

#vars for tile placing
var source_id = 1
var land_atlas = Vector2i(0,4)
var water_atlas = Vector2i(3,3)

var water_terrain = 0
var dirt_terrain = 1

var terrain_set = 0

@onready var tilemap: TileMapLayer = $Layer0

var world_seed = RandomNumberGenerator.new()

var developer_mode = false;


func _ready():
	noise = noise_texture.noise
	world_seed.randomize()  # Случайный сид (по времени)
	noise.set_seed(world_seed.randi())
	generate_world()


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_filedialog_delete"):
		developer_mode = !developer_mode
		if $player.has_method("update_deleloper_mode"):
			$player.update_deleloper_mode(developer_mode)


func generate_world():
	var dirt_cells = []
	var water_cells = []
	
	for x in range(width):
		for y in range(height):
			var noise_val = noise.get_noise_2d(x,y)
			if noise_val > 0.0:
				#place ground
				dirt_cells.append(Vector2i(x,y))
			elif noise_val < 0.0:
				#place water
				water_cells.append(Vector2i(x,y))
				
	# Place dirt terrain
	if dirt_cells.size() > 0:
		tilemap.set_cells_terrain_connect(dirt_cells, terrain_set, dirt_terrain, true)
	
	# Place water terrain
	if water_cells.size() > 0:
		tilemap.set_cells_terrain_connect(water_cells, terrain_set, water_terrain, true)
