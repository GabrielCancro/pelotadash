extends Node2D

var isHitted = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$Area2D.connect("body_entered",self,"on_body_enter")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func on_body_enter(body):
	if isHitted: return
	print("BREAK!!! ",body.name)
	if body==GC.PLAYER:
		isHitted = true		
		for spr in $Node2D.get_children():
			$Tween.interpolate_property(spr,"modulate",Color(1,1,1,1),Color(1,1,1,0),.8,Tween.TRANS_QUAD,Tween.EASE_OUT)
			$Tween.interpolate_property(spr,"position",spr.position,spr.position+Vector2(rand_range(80,250),rand_range(20,-80)),1,Tween.TRANS_QUAD,Tween.EASE_OUT)
			$Tween.interpolate_property(spr,"rotation",spr.rotation,spr.rotation+rand_range(-2,2),1,Tween.TRANS_QUAD,Tween.EASE_OUT)
		$Tween.start()
		yield(get_tree().create_timer(.1),"timeout")
		$KinematicBody2D.queue_free()
		yield(get_tree().create_timer(.9),"timeout")
		queue_free()
