extends Control

var carrousel_index = 1
var current_button_selected = null
onready var current_spark_counter = 0 #DG.PLAYER_DATA.sparks

func _ready():
	$HBox_Header/btn_back.connect("button_down",self,"on_click_button",["back"])
	$HBox_Header/btn_biomes.connect("button_down",self,"on_click_button",["biomes"])
	$HBox_Header/btn_powers.connect("button_down",self,"on_click_button",["powers"])
	$HBox_Header/btn_skins.connect("button_down",self,"on_click_button",["skins"])
	$HBox_Header/btn_musics.connect("button_down",self,"on_click_button",["musics"])
	$btn_buy.connect("button_down",self,"on_click_button",["buy"])
	$btn_sparks.connect("button_down",self,"on_click_button",["sparks"])
	on_click_button("biomes")
	current_spark_counter = DG.PLAYER_DATA.sparks
	
func _process(delta):
	var step = (DG.PLAYER_DATA.sparks-current_spark_counter) * 0.1
	current_spark_counter += step 
	if abs(step)<1: current_spark_counter = DG.PLAYER_DATA.sparks
	$lb_sparks.text = "SPARKS "+str(floor(current_spark_counter))

func on_click_button(code):
	if current_button_selected:
		current_button_selected.set_selected(false)
		current_button_selected = null
	if code=="back": 
		get_tree().change_scene("res://scenes/MainMenu.tscn")
	elif code=="biomes": 
		current_button_selected = $HBox_Header/btn_biomes
		current_button_selected.set_selected(true)
		$Carrousel.fill_carrousel_items("biomes")
	elif code=="powers": 
		current_button_selected = $HBox_Header/btn_powers
		current_button_selected.set_selected(true)
		$Carrousel.fill_carrousel_items("powers")
	elif code=="skins": 
		current_button_selected = $HBox_Header/btn_skins
		current_button_selected.set_selected(true)
		$Carrousel.fill_carrousel_items("skins")
	elif code=="musics": 
		current_button_selected = $HBox_Header/btn_musics
		current_button_selected.set_selected(true)
		$Carrousel.fill_carrousel_items("musics")
	elif code=="buy":
		var pack = $Carrousel.get_current_pack()
		var pack_data = pack.get_data()
		if(!DG.PLAYER_DATA.packs_getted.has(pack_data.name)):
			if(pack_data.price<=DG.PLAYER_DATA.sparks):
				DG.PLAYER_DATA.sparks -= pack_data.price
				DG.PLAYER_DATA.packs_getted.append(pack_data.name)
				pack.refresh_data()
				DG.save_data()
	elif code=="sparks":
		DG.PLAYER_DATA.sparks += 500
		DG.save_data()
