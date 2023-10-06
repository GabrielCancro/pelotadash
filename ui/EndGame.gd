extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$btn_retry.connect("button_down",self,"on_retry_button")
	$btn_menu.connect("button_down",self,"on_menu_button")
	pass # Replace with function body.

func on_retry_button():
	get_tree().reload_current_scene()
	get_tree().paused = false
	GC.SCORE = 0

func on_menu_button():
	get_tree().change_scene("res://scenes/MainMenu.tscn")

func show_end_panel(win):
	visible = true
	if win: $lb_gameover.text = "YOU WIN !!"
