extends Node2D

export var randomBlocks = true #if block creation is random or not
export var total_blocks = 2 #amount of blocks in this level 
export var speed = 300

var block_scenes #array of block scenes availables

onready var screen_view = GC.GAME_SIZE.x * GC.CAMERA.zoom.x
var block_list = [] #array of block that will create in secuential order
var block_index = 0 #index of the next block to be instantiated
var level_length = 0 #total distance of the level
var level_elapsed = 0 #player distance elapsed 
var instanced_blocks = [] #array of blocks currently intanced in the level
var last_block_instanced

var distance_elapsed = 0
var next_spark = 0

func _ready():
	GC.LEVEL = self
	block_scenes = DG.get_available_block_scenes_list()
	create_block_list()
	add_next_block(0)
	print("screen_view ",screen_view)

func _process(delta):
	speed += .5*delta
	distance_elapsed += speed*delta
	check_new_spark()
	for block in get_children():
		block.position.x -= speed*delta
		var end_xpos = block.position.x + block.width
		if block == last_block_instanced && end_xpos < 3000:
			add_next_block(end_xpos)
		if end_xpos < -1000:
			remove_block(block)

func add_next_block(_x):
	if(block_index>=block_list.size()): return
	print("BLOCK INDEX ",block_index)
	var block
	var block_id = block_list[block_index]
	if block_id==-1: block = preload("res://blocks/endBlock.tscn").instance()
	else: block = block_scenes[ block_id ].instance()
	block.position.x = _x
	instanced_blocks.append(block)
	last_block_instanced = block
	add_child(block)
	block_index += 1

func create_block_list():
	var block_id
	var last_block_id = -1
	block_list = []
	if randomBlocks: randomize()
	for i in range(total_blocks):
		if randomBlocks: 
			block_id = randi() % block_scenes.size()
			if block_id==last_block_id: block_id = rand_range(0,block_scenes.size()-1)
			last_block_id = block_id
		else: 
			block_id = i % block_scenes.size()
		block_list.append(block_id)
	block_list.append(-1)
	print("BLOCKS LIST ",block_list)

func remove_block(block):
	instanced_blocks.erase(block)
	block.queue_free()

func check_new_spark():
	if distance_elapsed >= next_spark:
		next_spark += 100
		var spark = preload("res://levelObjects/Spark.tscn").instance()
		last_block_instanced.add_child(spark)
		spark.global_position = Vector2(2000,rand_range(-200,600))
