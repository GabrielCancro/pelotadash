extends Node2D

var width
var isLastBlock = true

func _ready():
	width = $Sizer.rect_size.x
