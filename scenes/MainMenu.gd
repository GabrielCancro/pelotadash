extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	$btn_start.connect("button_down",self,"on_click_button",["start"])
	$btn_shop.connect("button_down",self,"on_click_button",["shop"])
	$btn_quit.connect("button_down",self,"on_click_button",["quit"])
	$lb_sparks.text = "SPARKS "+str(DG.PLAYER_DATA.sparks)

	$Tween.interpolate_property(GC,"SCORE",GC.SCORE,0,2,Tween.TRANS_QUAD,Tween.EASE_OUT,.5)
	$Tween.start()

func _process(delta):
	pass
		
func on_click_button(code):
	if code=="start": get_tree().change_scene("res://scenes/SelectLevel.tscn")
	elif code=="shop": get_tree().change_scene("res://scenes/ShopMenu.tscn")
	elif code=="quit": get_tree().quit()
