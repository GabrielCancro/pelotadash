extends Node

var PLAYER
var LEVEL
var LEVEL_SPEED = 400
var CAMERA
var UI
var SCORE = 0
onready var GAME_SIZE = get_viewport().get_visible_rect().size

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func end_game(win=false):
	get_tree().paused = true
	yield(get_tree().create_timer(.5),"timeout")
	get_node("/root/Game/CanvasLayer/UI").visible = false
	get_node("/root/Game/CanvasLayer/EndGame").show_end_panel(win)
