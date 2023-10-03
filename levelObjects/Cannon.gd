extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("body_entered",self,"onEnterBody")

func onEnterBody(body):
	if body==GC.PLAYER:
		var dir = Vector2(1, 0).rotated(rotation-PI/8)
		var pos = global_position + dir * 100
		GC.PLAYER.shoot_to(dir,2500,pos)
		
