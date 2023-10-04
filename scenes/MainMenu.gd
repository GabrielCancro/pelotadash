extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$btn_start.connect("button_down",self,"on_start_button")

func on_start_button():
	get_tree().change_scene("res://scenes/Game.tscn")
