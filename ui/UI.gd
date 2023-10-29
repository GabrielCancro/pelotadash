extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	GC.UI = self
	$lb_level.text = "LEVEL "+str(DG.PLAYER_DATA.level)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(GC.PLAYER): $lb_vel.text = "vel: " + str( floor(GC.LEVEL.speed) )
#	if(GC.PLAYER): $lb_posy.text = "posY: " + str( floor(GC.PLAYER.position.y) )
	$lb_distance.text = "DISTANCE "+str(floor(GC.LEVEL.elapsed_distance/300))+" / "+str(floor(GC.LEVEL.total_distance/300))
#	$lb_blocks.text = "BLOCK: "+str(GC.LEVEL.block_index) + " / " + str(GC.LEVEL.block_list.size())
#	GC.SCORE += delta*10
	$lb_score.text = str(floor(GC.SCORE))
