extends Control

var carrousel_index = 1
onready var orig_pos_left = $Left_ShopCarrouselItem.rect_position
onready var orig_pos_middle = $Middle_ShopCarrouselItem.rect_position
onready var orig_pos_right = $Right_ShopCarrouselItem.rect_position

func _ready():
	$bt_left.connect("button_down",self,"carrousel_back")
	$bt_right.connect("button_down",self,"carrousel_next")
	update_carrousel_data()

func update_carrousel_data(type="biomes"):
	$bt_left.modulate.a = .1
	$Left_ShopCarrouselItem.visible = (carrousel_index>0)
	if($Left_ShopCarrouselItem.visible): 
		$bt_left.modulate.a = 1
		var keyL = DG.BIOMEPACK_DATA.keys()[carrousel_index-1]
		$Left_ShopCarrouselItem.set_data( DG.BIOMEPACK_DATA[keyL] )
	
	var keyM = DG.BIOMEPACK_DATA.keys()[carrousel_index]
	$Middle_ShopCarrouselItem.set_data( DG.BIOMEPACK_DATA[keyM] )
	
	$bt_right.modulate.a = .1
	$Right_ShopCarrouselItem.visible = (carrousel_index<DG.BIOMEPACK_DATA.size()-1)
	if($Right_ShopCarrouselItem.visible): 
		var keyR = DG.BIOMEPACK_DATA.keys()[carrousel_index+1]
		$Right_ShopCarrouselItem.set_data( DG.BIOMEPACK_DATA[keyR] )
		$bt_right.modulate.a = 1
	
	for point in $HBox.get_children():
		point.visible = (point.get_index()<DG.BIOMEPACK_DATA.size())
		if point.visible:
			if point.get_index() == carrousel_index: point.modulate = Color(1,1,0,1) 
			else: point.modulate = Color(.6,.6,.6,1)

func carrousel_next():
	if (carrousel_index<DG.BIOMEPACK_DATA.size()-1): carrousel_index += 1
	update_carrousel_data()

func carrousel_back():
	if(carrousel_index>0): carrousel_index -= 1
	update_carrousel_data()
