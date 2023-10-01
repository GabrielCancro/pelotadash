extends Node2D

var speed = 30

var randomBlocks = true
var block_scenes = [
	preload("res://blocks/block000.tscn"),
	preload("res://blocks/block001.tscn"),
	preload("res://blocks/block002.tscn"),
	preload("res://blocks/block003.tscn"),
	preload("res://blocks/block004.tscn"),
	preload("res://blocks/block005.tscn"),
]
var instanced_blocks = []
var next_block_index = 0

func _ready():
	randomize()
	GC.LEVEL = self
	add_new_block(0)

func _process(delta):
	speed += .5*delta
	for block in get_children():
		block.position.x -= speed*10*delta
		var end_xpos = block.position.x + block.width
		if block.isLastBlock && end_xpos < 3000:
			block.isLastBlock = false
			add_new_block(end_xpos)
		if end_xpos < -1000:
			remove_block(block)

func add_new_block(_x):
	var block = block_scenes[next_block_index].instance()
	block.position.x = _x
	instanced_blocks.append(block)
	add_child(block)
	if randomBlocks: 
		next_block_index = rand_range(0,block_scenes.size()-1)
	else:
		next_block_index += 1
		if next_block_index >= block_scenes.size(): next_block_index = 0

func remove_block(block):
	instanced_blocks.erase(block)
	block.queue_free()
