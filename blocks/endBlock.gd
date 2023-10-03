extends "res://blocks/blocks.gd"

func _ready():
	$Cannon.connect("on_throw_player",self,"end_game")

func end_game():
	yield(get_tree().create_timer(.5),"timeout")
	GC.end_game(true)
