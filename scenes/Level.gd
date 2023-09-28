extends Node2D

var speed = 50


# Called when the node enters the scene tree for the first time.
func _ready():
	GC.LEVEL = self

func _process(delta):
	speed += 1*delta
	for p in get_children():
		p.position.x -= speed*10*delta
		if p.position.x < -1000: p.position.x = 2100
