extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Button.connect("button_down",self,"onButtonClick")
	pass # Replace with function body.

func onButtonClick():
	get_tree().reload_current_scene()
	get_tree().paused = false
	GC.SCORE = 0
