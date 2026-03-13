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

func _ready():
	noise = noise_texture.noise
	generate_world()
	

func generate_world():
	for x in range(width):
		for y in range(height):
			var noise_val = noise.get_noise_2d(x,y)
			if noise_val > 0.0:
				#place ground
				tilemap.set_cells_terrain_connect([Vector2i(x,y)], terrain_set, dirt_terrain, true)
			elif noise_val < 0.0:
				#place ground
				tilemap.set_cells_terrain_connect([Vector2i(x,y)], terrain_set, water_terrain, true)
				#tilemap.set_cell(Vector2i(x,y), source_id, water_atlas)
				pass
