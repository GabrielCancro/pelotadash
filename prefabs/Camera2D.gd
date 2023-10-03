extends Camera2D

onready var posy = GC.GAME_SIZE.y / 2
var speed_y_mult = 5
var margin = 200

func _ready():
	GC.CAMERA = self

func _process(delta):
	var dist = (GC.PLAYER.position.y - posy)
	if abs(dist)>margin:
		posy = posy + dist * delta * speed_y_mult
		position.y = posy
