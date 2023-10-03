extends Node2D

var score = 10
var speed = 0
var getted = false
var dist_to_player
var light_timer = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	z_index = -1

func _process(delta):
	dist_to_player = global_position.distance_to(GC.PLAYER.global_position)
	if light_timer<.1: light_timer += delta
	else:
		light_timer = 0
		scale.x = rand_range(.3,.6)
		scale.y = rand_range(.4,.8)
		modulate.a = rand_range(.6,.8)
	if !getted:
		if dist_to_player<200: getted = true
	else:
		speed += delta * 40
		global_position += global_position.direction_to(GC.PLAYER.global_position)*speed
		if(dist_to_player<=speed*2):
			GC.SCORE += score
			queue_free()

