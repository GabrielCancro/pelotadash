extends Control

var isWin = false
var isCounting = false

func _ready():
	$HBox/btn_retry.connect("button_down",self,"on_retry_button")
	$HBox/btn_menu.connect("button_down",self,"on_menu_button")
	$lb_collect.text = ""
	visible = false
	set_process(false)

func _process(delta):
	$lb_collect.text = "SPARKS "+str(DG.PLAYER_DATA.sparks)
	if GC.SCORE>0: $lb_add_sparks.text = "+"+str(GC.SCORE)
	else: $lb_add_sparks.text = ""
	if isCounting:
		if GC.SCORE>0:
			var step = ceil(GC.SCORE*0.01)
			DG.PLAYER_DATA.sparks += step
			GC.SCORE -= step
#			print(DG.PLAYER_DATA.sparks,"  ",step,"  ",GC.SCORE)
		else: isCounting=false

func on_retry_button():
	get_tree().reload_current_scene()
	get_tree().paused = false
	GC.SCORE = 0

func on_menu_button():
	if isWin: DG.PLAYER_DATA.sparks += GC.SCORE
	else: GC.SCORE = 0
	DG.save_data()
	get_tree().paused = false
	get_tree().change_scene("res://scenes/MainMenu.tscn")

func show_end_panel(win):
	set_process(true)
	$lb_add_sparks.text = ""
	$lb_dec_sparks.visible = false
	get_node("../UI").visible = false
	$HBox/btn_retry.visible = false
	$HBox/btn_menu.visible = false
	isWin = win
	visible = true
	if GC.SCORE>0:
		if win: 
			$lb_gameover.text = "YOU WIN !!"
			$lb_dec_sparks.visible = false
		else:
			$lb_gameover.text = "GAME OVER"
			var dec_sparks = floor(GC.SCORE/2)
			$lb_dec_sparks.text = "-"+str(dec_sparks)
			yield(get_tree().create_timer(1.5),"timeout")
			$lb_dec_sparks.visible = true
			$Tween.interpolate_property($lb_dec_sparks,"modulate",Color(1,1,1,1),Color(1,1,1,0),1.5,Tween.TRANS_QUINT,Tween.EASE_IN)
			$Tween.start()
			GC.SCORE -= dec_sparks
		yield(get_tree().create_timer(2),"timeout")
		isCounting = true
		yield(get_tree().create_timer(1.2),"timeout")
	$HBox/btn_retry.visible = !isWin
	$HBox/btn_menu.visible = true
