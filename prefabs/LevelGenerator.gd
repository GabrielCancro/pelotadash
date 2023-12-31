extends Node2D

var speed = 250
var max_speed = 360
var elapsed_distance = 0
var total_distance = 4500 + 2000
var end_generation = false
var next_platform = 0

var last_block_instanced
var next_spark = 1000

var max_jump_horizontal_distance = 100 #320
var min_jump_horizontal_distance = 100
var height_level = 0
var max_jump_height = 1
var obstacles_percent = 20
var spark_distance = 200

func _ready():
	randomize()
	GC.LEVEL = self
	create_start_platforms()

func _process(delta):
	if(speed<max_speed): speed += delta*2.5
	if elapsed_distance < total_distance: elapsed_distance += speed*delta
	else: elapsed_distance = total_distance
	check_end_platform()
	check_new_platform()
	check_new_spark()
	for obj in get_children():
		if !is_instance_valid(obj): continue
		obj.position.x -= speed*delta
		if !end_generation && obj.position.x<-1000: obj.queue_free()

func check_new_platform():
	if end_generation: return
	if elapsed_distance>=next_platform: 
		var obj = add_platform()
		next_platform = elapsed_distance + obj.get_node("Sizer").rect_size.x + rand_range(min_jump_horizontal_distance,max_jump_horizontal_distance)
		print("next_platform ",next_platform)

func add_platform():
	var platform = get_random_platform()
	platform.position.x = 2000
	platform.position.y = GC.GAME_SIZE.y-height_level * 100
	add_child(platform)
	last_block_instanced = platform
	print("ADD PLATFORM IN H:",height_level)
	height_level = floor(rand_range( max(height_level-2,-2),min(height_level+max_jump_height+1,7)))
	set_obstacles_in_platform(platform)
	return platform

func get_random_platform():
	var index = randi()%DG.BLOCK_DATA[DG.PLAYER_DATA.current_biome]["platforms"].size()
	return DG.BLOCK_DATA[DG.PLAYER_DATA.current_biome]["platforms"][index].instance()

func create_start_platforms():
	for i in range(2):
		var platform = preload("res://levelObjects/natural_objects/Platform_L.tscn").instance()
		platform.position.x = 400+i*850
		platform.position.y = GC.GAME_SIZE.y+100
		add_child(platform)
		last_block_instanced = platform

func check_new_spark():
	if end_generation: return
	if elapsed_distance+1000 >= next_spark:
		next_spark += spark_distance
		var spark = preload("res://levelObjects/Spark.tscn").instance()
		last_block_instanced.add_child(spark)
		spark.global_position.x = 2000
		spark.position.y = rand_range(-100,-500)

func check_end_platform():
	if end_generation: return
	if elapsed_distance+2000 >= total_distance:
		end_generation = true
		var platform = preload("res://blocks/endBlock.tscn").instance()
		platform.position.x = 2000
		platform.position.y = GC.GAME_SIZE.y-height_level * 100
		add_child(platform)
		last_block_instanced = platform

func set_obstacles_in_platform(platform):
	var points = platform.get_node_or_null("ObstaclePoints")
	if !points: return
	for pt in points.get_children():
		if randi()%100<obstacles_percent:
			var obs = get_random_obstacle(30)
			if obs: pt.add_child(obs)

func get_random_obstacle(percent = 100):
	var index = randi()%DG.BLOCK_DATA[DG.PLAYER_DATA.current_biome]["obstacles"].size()
	return DG.BLOCK_DATA[DG.PLAYER_DATA.current_biome]["obstacles"][index].instance()
