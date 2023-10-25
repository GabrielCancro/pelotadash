extends Control

var isWin = false
var dec_sparks = 0
var current_sparks = 0
var sparks_adding_amount = 0
signal end_animation

onready var score_font = $lb_score.get_font("font", "Label")
var addingFontSize = false

func _ready():
	$lb_line.modulate.a = 0
	$Buttons.visible = false
	$Buttons.modulate.a = 0
	score_font.size = 32
	$Buttons/btn_menu.connect("button_down",self,"on_click_button",["menu"])
	$Buttons/btn_retry.connect("button_down",self,"on_click_button",["retry"])

func _process(delta):
	current_sparks = myLerp(current_sparks,DG.PLAYER_DATA.sparks)
	$lb_score.text = str(floor(GC.SCORE))
	
	if addingFontSize:
		if score_font.size < 100: score_font.size += (120-score_font.size)*0.05
		else: 
			addingFontSize = false
			yield(get_tree().create_timer(.5),"timeout")
			emit_signal("end_animation")
	
	if sparks_adding_amount != 0:
		var step = sparks_adding_amount * 0.1
		GC.SCORE += step
		sparks_adding_amount -= step
		if(abs(step)<0.01): 
			sparks_adding_amount = 0
			yield(get_tree().create_timer(.5),"timeout")
			emit_signal("end_animation")

func show_end_panel(win):
	addingFontSize = true
	visible = true
	isWin = win
	yield(self,"end_animation")
	if !win && GC.SCORE>1:
		var dec_spark = floor(GC.SCORE/2)
		$lb_line.text = "YOU LOSE!  -"+str(dec_spark)
		$Tween.interpolate_property($lb_line,"modulate",Color(1,1,1,0),Color(1,1,1,1),.5,Tween.TRANS_QUAD,Tween.EASE_OUT)
		$Tween.start()
		yield(get_tree().create_timer(1),"timeout")
		sparks_adding_amount = -dec_spark
		yield(self,"end_animation")
		$Tween.interpolate_property($lb_line,"modulate",Color(1,1,1,1),Color(1,1,1,0),.5,Tween.TRANS_QUAD,Tween.EASE_OUT)
		$Tween.start()
		yield(get_tree().create_timer(.6),"timeout")
		
	$Buttons.visible = true
	$Tween.interpolate_property($Buttons,"modulate",Color(1,1,1,0),Color(1,1,1,1),.5,Tween.TRANS_QUAD,Tween.EASE_OUT)
	$Tween.start()


func on_click_button(code):
	if code=="retry":
		GC.SCORE = 0
		get_tree().reload_current_scene()
		get_tree().paused = false
	elif code=="menu":
		GC.SCORE = 0
		DG.save_data()
		get_tree().paused = false
		get_tree().change_scene("res://scenes/MainMenu.tscn")

func myLerp(val1,val2):
	val1 += ceil( ( val2 - val1 ) * 0.1 )
	return val1
	
