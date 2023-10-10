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

var PLAYER_DATA = {
	"sparks":0, 
	"current_skin":"sk1", 
	"current_music":"ms1", 
	"current_biome":"natural"
}

var BIOMEPACK_DATA = {
	"bpack1":{"biome":"natural","img":"b_natural", "price":0, "getted":true, "req_pack":0, "req_power":"", "blocks":["b1","b2","b3"]},
	"bpack2":{"biome":"natural","img":"b_natural", "price":1200, "getted":false, "req_pack":0, "req_power":"", "blocks":["b4"]},
	"bpack3":{"biome":"natural","img":"b_natural", "price":1200, "getted":false, "req_pack":0, "req_power":"", "blocks":["b5"]},
	"bpack4":{"biome":"natural","img":"b_natural", "price":1200, "getted":false, "req_pack":0, "req_power":"", "blocks":["b6"]},
}

var POWERPACK_DATA = {
	"ppack1":{"name":"Super Jump","img":"p_super_jump","desc":"Jump higher holding SPACE" ,"price":1000,"getted":false},
}

var SKINPACK_DATA = {
	"spack1":{"name":"Normal Boy","img":"s_pokebomb", "price":1000,"getted":false},
}

var MUSICPACK_DATA = {
	"mpack1":{"name":"Jungle Relax","img":"m_jungle_relax", "price":1000,"getted":false},
}

var IMAGES = {
	"b_natural":preload("res://assets/packs/biome_natural.jpg"),
	"p_super_jump":preload("res://assets/packs/power_super_jump.jpg"),
	"s_pokebomb":preload("res://assets/packs/skin_pokebomb.jpg"),
	"m_jungle_relax":preload("res://assets/packs/music_jungle_relax.jpg"),
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

func save_data():
	var file = File.new()
	file.open("gameData.sav", File.WRITE)
	var full_data = {
		"player": PLAYER_DATA,
		"biomepack": BIOMEPACK_DATA,
	}
	file.store_string(to_json(full_data))
	file.close()

func load_data():
	var file = File.new()
	if file.file_exists("gameData.sav"):
		file.open("gameData.sav", File.READ)
		var data = parse_json(file.get_as_text())
		file.close()
		if typeof(data) == TYPE_DICTIONARY:
			PLAYER_DATA = data.player
			BIOMEPACK_DATA = data.biomepack
		else:
			printerr("Corrupted data!")
	else:
		printerr("No saved data!")
