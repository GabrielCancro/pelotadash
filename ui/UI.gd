extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(GC.PLAYER): 
		$Label.text = "vel: " + str( floor((GC.PLAYER as RigidBody2D).linear_velocity.x/10)*10 )
