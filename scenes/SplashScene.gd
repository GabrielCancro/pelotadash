extends Control

func _ready():
	DG.load_data()
	get_tree().change_scene("res://scenes/MainMenu.tscn")
