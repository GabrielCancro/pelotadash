extends Node

var PLAYER
var LEVEL
var CAMERA
var UI
var SCORE = 0
onready var GAME_SIZE = get_viewport().get_visible_rect().size

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func end_game():
	get_tree().paused = true
	yield(get_tree().create_timer(.5),"timeout")
	get_node("/root/Main/CanvasLayer/EndGame").visible = true
