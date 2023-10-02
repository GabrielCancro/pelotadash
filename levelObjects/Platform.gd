extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite.scale.x = 1 / scale.x 
	$Sprite.scale.y = 1 / scale.y 
	$Sprite.region_rect.size.x = 64 * scale.x
	$Sprite.region_rect.size.y = 64 * scale.y
	pass
#	$TextureRect.rect_size *= scale
#	$TextureRect.rect_scale /= scale
#	$TextureRect.rect_position = -$TextureRect.rect_size / 2
