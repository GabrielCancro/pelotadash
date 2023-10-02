extends Camera2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var CAMERA_STEP_SIZE = GC.GAME_SIZE.y / 2
var CURRENT_STEP = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	GC.CAMERA = self


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#$Camera2D.position.y = GC.PLAYER.position.y - (GC.PLAYER.position.y - GC.PLAYER.last_min_y) / 2 -20
	
#	position.y = GC.PLAYER.position.y
	
#	var media_player_position_y = GC.PLAYER.position.y
#	var camera_step_y = floor( media_player_position_y/CAMERA_STEP_SIZE ) + 0
#	position.y = camera_step_y*CAMERA_STEP_SIZE
#	print("media:",media_player_position_y,"   step:",camera_step_y,"   pos:",position.y,"   GameSize:",GC.GAME_SIZE.y)

	if(GC.PLAYER.position.y<CURRENT_STEP*CAMERA_STEP_SIZE-CAMERA_STEP_SIZE+50): CURRENT_STEP -= 1
	if(GC.PLAYER.position.y>CURRENT_STEP*CAMERA_STEP_SIZE+CAMERA_STEP_SIZE-100): CURRENT_STEP += 1
	position.y = CURRENT_STEP*CAMERA_STEP_SIZE - CAMERA_STEP_SIZE / 4
