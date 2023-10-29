extends Control


func _ready():
	$btn_start.connect("button_down",self,"on_click_button",["start"])
	$btn_back.connect("button_down",self,"on_click_button",["back"])
	$lb_level.text = "LEVEL "+str(DG.PLAYER_DATA.level)

	$Tween.interpolate_property(GC,"SCORE",GC.SCORE,0,2,Tween.TRANS_QUAD,Tween.EASE_OUT,.5)
	$Tween.start()

func _process(delta):
	pass
		
func on_click_button(code):
	if code=="start": get_tree().change_scene("res://scenes/Game.tscn")
	elif code=="back": get_tree().change_scene("res://scenes/MainMenu.tscn")
