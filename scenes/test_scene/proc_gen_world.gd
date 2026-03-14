extends Node2D

#noise for procedural generation
@export var noise_texture : NoiseTexture2D
var noise : Noise

#map size
var width : int = 100
var height : int = 100

#vars for tile placing
var source_id = 1


# terrain layer id's for generation
var dirt_terrain_id = 0
var water_terrain_id = 0
var gravel_terrain_id = 0

#terrain sets 
var dirt_terrain_set = 0
var water_terrain_set = 1
var gravel_terrain_set = 2

#@onready var tilemap: TileMapLayer = $Layer0
@onready var tilemap: TileMapLayer = $TileMap

var world_seed = RandomNumberGenerator.new()

var developer_mode = true;


func _ready():
	noise = noise_texture.noise
	world_seed.randomize()  # Случайный сид (по времени)
	noise.set_seed(world_seed.randi())
	generate_world()


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("dev_mode"):
		developer_mode = !developer_mode
		if $player.has_method("update_deleloper_mode"):
			$player.update_deleloper_mode(developer_mode)

func generate_world():
	var dirt_cells = []
	var water_cells = []
	var gravel_cells = []
	
	for x in range(width):
		for y in range(height):
			var noise_val = noise.get_noise_2d(x,y)
			if noise_val > 0.4:
				#place gravel
				gravel_cells.append(Vector2i(x,y))
			elif noise_val < -0.4:
				#place water
				water_cells.append(Vector2i(x,y))
			else:
				#place dirt
				dirt_cells.append(Vector2i(x,y))
	# Place dirt terrain
	if dirt_cells.size() > 0:
		tilemap.set_cells_terrain_connect(dirt_cells, dirt_terrain_set, dirt_terrain_id, true)
		
	# Place gravel terrain
	if gravel_cells.size() > 0:
		tilemap.set_cells_terrain_connect(gravel_cells, gravel_terrain_set, gravel_terrain_id, true)
	
	# Place water terrain
	if water_cells.size() > 0:
		tilemap.set_cells_terrain_connect(water_cells, water_terrain_set, water_terrain_id, true)
