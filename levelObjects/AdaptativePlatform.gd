extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$StaticBody2D.position = rect_size/2
	$StaticBody2D.scale = rect_size/10/2


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
