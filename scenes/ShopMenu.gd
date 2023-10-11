extends Control

var carrousel_index = 1

func _ready():
	$HBox_Header/btn_back.connect("button_down",self,"on_click_button",["back"])
	$HBox_Header/btn_biomes.connect("button_down",self,"on_click_button",["biomes"])
	$HBox_Header/btn_powers.connect("button_down",self,"on_click_button",["powers"])
	$HBox_Header/btn_skins.connect("button_down",self,"on_click_button",["skins"])
	$HBox_Header/btn_musics.connect("button_down",self,"on_click_button",["musics"])


func on_click_button(code):
	if code=="back": get_tree().change_scene("res://scenes/MainMenu.tscn")
	elif code=="biomes": $Carrousel.fill_carrousel_items("biomes")
	elif code=="powers": $Carrousel.fill_carrousel_items("powers")
	elif code=="skins": $Carrousel.fill_carrousel_items("skins")
	elif code=="musics": $Carrousel.fill_carrousel_items("musics")
