extends KinematicBody2D

var jumpingTime = 1
export var jumpBase = 700
export var jumpMult = 1.5
var jumpPower
export var gravity = 40
var velocity = Vector2()
export var moveBase = 200
var last_min_y = 300

func _ready():
	pass
#	GC.PLAYER = self

func _process(delta): 
	velocity.y += gravity
	if Input.is_action_pressed("right"): position.x += moveBase*delta
	elif Input.is_action_pressed("left"): position.x -= moveBase*delta
	velocity.x *= 0.95
	velocity = move_and_slide(velocity,Vector2.UP)

	check_jump()
	check_dead()

func check_jump():
	if Input.is_action_pressed("jump"): jumpPower = jumpBase*jumpMult
	else: jumpPower = jumpBase
	if is_on_floor(): 
		last_min_y = position.y
		velocity.y = -jumpPower
		$AnimationPlayer.seek(0)
		$AnimationPlayer.play("jump")

func check_dead():
	if(position.y>1200): 
		GC.end_game()
