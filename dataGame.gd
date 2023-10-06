extends Node

var BLOCK_DATA = {
	"natural":{
		"b1":{ "getted":false, "scene":preload("res://blocks/natural/blk_natural_001.tscn")},
		"b2":{ "getted":false, "scene":preload("res://blocks/natural/blk_natural_001.tscn")},
		"b3":{ "getted":false, "scene":preload("res://blocks/natural/blk_natural_001.tscn")},
		"b4":{ "getted":false, "scene":preload("res://blocks/natural/blk_natural_001.tscn")},
		"b5":{ "getted":false, "scene":preload("res://blocks/natural/blk_natural_001.tscn")},
		"b6":{ "getted":false, "scene":preload("res://blocks/natural/blk_natural_001.tscn")},
	},
}

var SKIN_DATA = {
	"sk1":{"price":1000,"getted":false},
}

var MUSIC_DATA = {
	"ms1":{"price":1000,"getted":false},
}

var PLAYER_DATA = {
	"sparks":0, 
	"current_skin":"sk1", 
	"current_music":"ms1", 
	"current_biome":"natural"
}

var BIOMEPACK_DATA = {
	"bpack1":{"biome":"natural", "price":0, "getted":true, "req_pack":0, "req_power":"", "blocks":["b1","b2","b3"]},
	"bpack2":{"biome":"natural", "price":1200, "getted":false, "req_pack":0, "req_power":"", "blocks":["b4"]},
	"bpack3":{"biome":"natural", "price":1200, "getted":false, "req_pack":0, "req_power":"", "blocks":["b5"]},
	"bpack4":{"biome":"natural", "price":1200, "getted":false, "req_pack":0, "req_power":"", "blocks":["b6"]},
}

func _ready():
	init_getted_blocks()

func get_available_block_scenes_list():
	var biome = PLAYER_DATA.current_biome
	var array = []
	for i in BLOCK_DATA[biome]:
		var block = BLOCK_DATA[biome][i]
		if block.getted:
			array.append(block.scene)
	return array

func init_getted_blocks():
	for i in BIOMEPACK_DATA:
		var pack = BIOMEPACK_DATA[i]
		if pack.getted:
			for b in pack.blocks:
				BLOCK_DATA[pack.biome][b].getted = true
