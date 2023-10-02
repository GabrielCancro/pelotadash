extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	GC.UI = self


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(GC.PLAYER): $lb_vel.text = "vel: " + str( floor(GC.LEVEL.speed) )
	if(GC.PLAYER): $lb_posy.text = "posY: " + str( floor(GC.PLAYER.position.y) )
	$lb_blocks.text = "Bloques: "+str(GC.LEVEL.instanced_blocks.size())
	GC.SCORE += delta*10
	$lb_score.text = "SCORE "+str(floor(GC.SCORE))
