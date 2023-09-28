extends RigidBody2D

var maxSpeedX = 400
var maxSpeedY = 1200
var enabledJump = true
var jumpPower = 500
var jumping

func _ready():
	GC.PLAYER = self

func _physics_process(delta):
	if linear_velocity.x>=0 && linear_velocity.x<maxSpeedX: apply_impulse(Vector2.ZERO, Vector2(10,0))
	if linear_velocity.x<0 && linear_velocity.x>-maxSpeedX: apply_impulse(Vector2.ZERO, Vector2(-10,0))
	check_jump()
	$Sprite.rotation_degrees += linear_velocity.x/60

func _process(delta): pass

func check_jump():
	if enabledJump && Input.is_action_pressed("jump") && self.test_motion(Vector2(0, 1), false):
		enabledJump = false
		jumping = true
		linear_velocity.y = 0 
		apply_impulse(Vector2.ZERO, Vector2(0,-jumpPower))
		print("IMPULSE! y:",str(linear_velocity.y))
		$Tween.interpolate_property($Sprite,"modulate",Color(.3,.3,.3,1),Color(1,1,1,1),.2)
		$Tween.start()
		yield(get_tree().create_timer(.2),"timeout")
		enabledJump = true
