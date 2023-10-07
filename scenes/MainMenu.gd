extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	$btn_start.connect("button_down",self,"on_click_button",["start"])
	$btn_shop.connect("button_down",self,"on_click_button",["shop"])
	$btn_quit.connect("button_down",self,"on_click_button",["quit"])
	$lb_sparks.text = "SPARKS "+str(DG.PLAYER_DATA.sparks-ceil(GC.SCORE))
	if(GC.SCORE==0): $lb_add_sparks.text = ""
	$Tween.interpolate_property(GC,"SCORE",GC.SCORE,0,2,Tween.TRANS_QUAD,Tween.EASE_OUT,.5)
	$Tween.start()

func _process(delta):
	if GC.SCORE > 0:
		$lb_sparks.text = "SPARKS "+str(DG.PLAYER_DATA.sparks-ceil(GC.SCORE))
		$lb_add_sparks.text = "+ "+str(ceil(GC.SCORE))
	if(GC.SCORE==0): $lb_add_sparks.text = ""
		
func on_click_button(code):
	if code=="start": get_tree().change_scene("res://scenes/Game.tscn")
	elif code=="shop": get_tree().change_scene("res://scenes/ShopMenu.tscn")
	elif code=="quit": get_tree().quit()
