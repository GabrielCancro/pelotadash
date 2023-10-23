extends Control

var isWin = false
var dec_sparks = 0

func _ready():
	$HBoxBtn/btn_retry.connect("button_down",self,"on_click_button",["retry"])
	$HBoxBtn/btn_menu.connect("button_down",self,"on_click_button",["menu"])
	$HBoxBtn/btn_collect.connect("button_down",self,"on_click_button",["collect"])
	visible = false

func show_end_panel(win):
	isWin = win
	$lb_you_sparks.text = "SPARKS "+str(DG.PLAYER_DATA.sparks)
	set_grid_lines()
	visible = true

func set_grid_lines():
	$VBoxNum/lb_collected.text = "+"+str(GC.SCORE)

	dec_sparks = 0
	if(!isWin): dec_sparks = floor(GC.SCORE/2)
	$VBoxNum/lb_lose.text = "-"+str(dec_sparks)
	$VBoxNum/lb_lose.visible = !isWin
	$VBoxLab/lb_lose.visible = !isWin

	$VBoxNum/lb_total.text = "+"+str(GC.SCORE - dec_sparks)

func on_click_button(code):
	if code=="collect":
		DG.PLAYER_DATA.sparks += GC.SCORE - dec_sparks
		DG.save_data()
		$lb_you_sparks.text = "SPARKS "+str(DG.PLAYER_DATA.sparks)
		$HBoxBtn/btn_collect.visible = false
		$HBoxBtn/btn_retry.visible = !isWin
		$HBoxBtn/btn_menu.visible = true
	elif code=="retry":
		GC.SCORE = 0
		get_tree().reload_current_scene()
		get_tree().paused = false
	elif code=="menu":
		GC.SCORE = 0
		DG.save_data()
		get_tree().paused = false
		get_tree().change_scene("res://scenes/MainMenu.tscn")
