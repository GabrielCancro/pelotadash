extends Control

var isWin = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$btn_retry.connect("button_down",self,"on_retry_button")
	$btn_menu.connect("button_down",self,"on_menu_button")
	$lb_collect.text = ""

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
	visible = true
	isWin = win
	if win: 
		$lb_gameover.text = "YOU WIN !!"
		$btn_retry.visible = false
		$lb_collect.text = "You collected "+str(GC.SCORE)+" sparks!"
