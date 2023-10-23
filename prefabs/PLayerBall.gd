extends RigidBody2D

var movePower = 300
var jumpPower = 2100
var jumpoMult = 1.4
var jumpCooldown = 0
var lostControl = false
var fordwardCollisionCooldown = 0
onready var initial_position = position
var force_position = null

# Called when the node enters the scene tree for the first time.
func _ready():
	GC.PLAYER = self
	visible = true

func _physics_process(delta):
	angular_velocity = 0
	rotation = 0
	if lostControl: modulate = Color(.3,.3,.3,1)
	else: modulate = Color(1,1,1,1)
	check_horizontal_move(delta)
	check_jump(delta)
	check_dead()
	if force_position:
		position = force_position
		force_position = null

func check_horizontal_move(delta):
	$RayCast2DFordward.force_raycast_update()
	if($RayCast2DFordward.is_colliding()): lostControl = true
	if(!lostControl):
		if Input.is_action_pressed("right") && position.x<GC.GAME_SIZE.x*0.75: set_axis_velocity(Vector2(movePower,0))
		elif Input.is_action_pressed("left"): set_axis_velocity(Vector2(-movePower*1.5,0))
	set_axis_velocity( linear_velocity*0.98)
	

func check_jump(delta):
	if(jumpCooldown>0): jumpCooldown -= delta
	else: jumpCooldown = 0
	$RayCast2DLeft.force_raycast_update()
	$RayCast2DRight.force_raycast_update()
	if($RayCast2DLeft.is_colliding() || $RayCast2DRight.is_colliding()):
		lostControl = false
		if(jumpCooldown<=0):
			jumpCooldown = .3
			if Input.is_action_pressed("jump"): apply_central_impulse(Vector2(0,-jumpPower*jumpoMult))
			else: apply_central_impulse(Vector2(0,-jumpPower))
			$AnimationPlayer.seek(0)
			$AnimationPlayer.play("jump")

func check_dead():
	if(position.y>1200 || position.x<-400): 
		linear_velocity *= 0
		angular_velocity *= 0
		position = initial_position
		visible = false
		GC.end_game()

func shoot_to(angle,power,pos=null):
	lostControl = true
	set_axis_velocity(angle*power)
	if(pos): force_position = pos
