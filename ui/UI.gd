extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(GC.PLAYER): $lb_vel.text = "vel: " + str( floor(GC.LEVEL.speed) )
	if(GC.PLAYER): $lb_posy.text = "posY: " + str( floor(GC.PLAYER.position.y) )
	$lb_blocks.text = "Bloques: "+str(GC.LEVEL.instanced_blocks.size())
