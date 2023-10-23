extends Control

var isWin = false
var dec_sparks = 0
var current_sparks = 0

func _ready():
	$HBoxBtn/btn_retry.connect("button_down",self,"on_click_button",["retry"])
	$HBoxBtn/btn_menu.connect("button_down",self,"on_click_button",["menu"])
	$HBoxBtn/btn_collect.connect("button_down",self,"on_click_button",["collect"])
	visible = false

func _process(delta):
	current_sparks = myLerp(current_sparks,DG.PLAYER_DATA.sparks)
	$lb_you_sparks.text = "SPARKS "+str(current_sparks)

func show_end_panel(win):
	isWin = win
	current_sparks = DG.PLAYER_DATA.sparks
	$lb_you_sparks.text = "SPARKS "+str(current_sparks)
	set_grid_lines()
	visible = true

func set_grid_lines():
	$VBoxNum/lb_collected.text = "+"+str(GC.SCORE)
	if(GC.SCORE==0): $VBoxNum/lb_collected.text = "-"

	dec_sparks = 0
	if(!isWin): dec_sparks = floor(GC.SCORE/2)
	$VBoxNum/lb_lose.text = "-"+str(dec_sparks)
	if(dec_sparks==0): $VBoxNum/lb_lose.text = "-"
	$VBoxNum/lb_lose.visible = !isWin
	$VBoxLab/lb_lose.visible = !isWin

	$VBoxNum/lb_total.text = "+"+str(GC.SCORE - dec_sparks)
	if(GC.SCORE-dec_sparks==0): $VBoxNum/lb_total.text = "-"

func on_click_button(code):
	if code=="collect":
		DG.PLAYER_DATA.sparks += GC.SCORE - dec_sparks
		DG.save_data()
		$HBoxBtn/btn_collect.visible = false
		$HBoxBtn/btn_retry.visible = !isWin
		$HBoxBtn/btn_menu.visible = true
		$Tween.interpolate_property($VBoxLab,"modulate",Color(1,1,1,1),Color(1,1,1,0),.5,Tween.TRANS_QUAD,Tween.EASE_IN)
		$Tween.interpolate_property($VBoxNum,"modulate",Color(1,1,1,1),Color(1,1,1,0),.5,Tween.TRANS_QUAD,Tween.EASE_IN)
		$Tween.interpolate_property($lb_you_sparks,"rect_position",$lb_you_sparks.rect_position,$lb_you_sparks.rect_position+Vector2(0,70),1,Tween.TRANS_QUAD,Tween.EASE_OUT)
		$Tween.start()
	elif code=="retry":
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
	
