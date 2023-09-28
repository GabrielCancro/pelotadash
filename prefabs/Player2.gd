extends KinematicBody2D

var jumpingTime = 1
var jumpPower = 1000
var isJumping
var gravity = 40
var velocity = Vector2()


# Called when the node enters the scene tree for the first time.
func _ready():
	GC.PLAYER = self

func _process(delta): 
	velocity.y += gravity
	velocity = move_and_slide(velocity,Vector2.UP)
	check_jump()


func check_jump():
	if is_on_floor() && Input.is_action_pressed("jump"):
		velocity.y -= jumpPower
		isJumping = true
	if isJumping && velocity.y > -jumpPower*.01: isJumping = false
	if isJumping && velocity.y < -jumpPower*0.2 && !Input.is_action_pressed("jump"):
		isJumping = false
		velocity.y *= 0.5
