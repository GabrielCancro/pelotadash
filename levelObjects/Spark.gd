extends Node2D

var score = 10
var speed = 0
var getted = false
var dist_to_player
var light_timer = 0
var ttl = 0
onready var rnd_move = Vector2(randf(),randf())

# Called when the node enters the scene tree for the first time.
func _ready():
	z_index = -1

func _process(delta):
	ttl += delta
	dist_to_player = global_position.distance_to(GC.PLAYER.global_position)
	if light_timer<.1: light_timer += delta
	else:
		light_timer = 0
		scale.x = rand_range(.5,.6)
		scale.y = rand_range(.5,.6)
		modulate.a = rand_range(.7,.9)
	if !getted:
		position.x += sin(ttl)*rnd_move.x
		position.y += sin(ttl)*rnd_move.y
		if dist_to_player<200: 
			getted = true
			GC.SCORE += score
	else:
		speed += delta * 80
		global_position += global_position.direction_to(GC.PLAYER.global_position)*speed
		if(dist_to_player<=speed*2):
			queue_free()

