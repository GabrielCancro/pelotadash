extends CanvasLayer

onready var move_size = $Texture.rect_size.y-600
var camera_offset = 300

func _ready():
	pass

func _process(delta):
	var destine = clamp(camera_offset-GC.CAMERA.position.y,-move_size,0)
	$Texture.rect_position.y += (destine - $Texture.rect_position.y)*delta
