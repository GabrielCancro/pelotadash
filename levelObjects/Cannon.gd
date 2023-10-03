extends Area2D

export var power = 2500

signal on_throw_player()

func _ready():
	connect("body_entered",self,"onEnterBody")

func onEnterBody(body):
	if body==GC.PLAYER:
		var dir = Vector2(1, 0).rotated(rotation-PI/8)
		var pos = global_position + dir * 100
		GC.PLAYER.shoot_to(dir,power,pos)
		emit_signal("on_throw_player")
