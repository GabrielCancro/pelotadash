extends Control

var carrousel_index = 1

func _ready():
	$btn_back.connect("button_down",self,"on_back_button")

func on_back_button():
	get_tree().change_scene("res://scenes/MainMenu.tscn")
