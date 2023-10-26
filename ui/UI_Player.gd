extends Node2D

var ttl = 0
onready var start_y = position.y
var vel_y = 0

func _ready():
	pass

func _process(delta):
	position.y += vel_y*delta
	vel_y += 1300*delta
	if(position.y>=start_y): vel_y = -700

