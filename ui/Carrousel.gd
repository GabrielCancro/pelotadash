extends Control

var carrousel_item_scene = preload("res://ui/ShopCarrouselItem.tscn")
var carrousel_index = {"biomes":0, "powers":0, "skins":0, "musics":0}
var current_carrousel_item
var current_type
var PACK_DATA

func _ready():
	$bt_left.connect("button_down",self,"carrousel_back")
	$bt_right.connect("button_down",self,"carrousel_next")
	fill_carrousel_items("biomes")

func fill_carrousel_items(_type):
	current_type = _type
	PACK_DATA = DG.PACK_DATA[_type]
	
	var i = 0
	for old in $ItemsList.get_children(): 
		$ItemsList.remove_child(old)
		old.queue_free()
	for pack in PACK_DATA:
		var cr = carrousel_item_scene.instance()
		cr.set_data(current_type, pack)
		cr.rect_position.x += (cr.rect_size.x + 30) * i
		$ItemsList.add_child(cr)
		i+=1
	current_carrousel_item = null
	yield(get_tree().create_timer(.1),"timeout")
	update_carrousel_data()

func update_carrousel_data():
	print(carrousel_index[current_type])
	if(current_carrousel_item): current_carrousel_item.set_selected(false)
	current_carrousel_item = $ItemsList.get_children()[carrousel_index[current_type]]
	current_carrousel_item.set_selected(true)
	if(carrousel_index[current_type]>0):$bt_left.modulate.a = 1
	else: $bt_left.modulate.a = .1
	if(carrousel_index[current_type]<PACK_DATA.size()-1): $bt_right.modulate.a = 1
	else: $bt_right.modulate.a = .1
	
	for point in $HBox.get_children():
		point.visible = (point.get_index()<PACK_DATA.size())
		if point.visible:
			if point.get_index() == carrousel_index[current_type]: point.modulate = Color(1,1,0,1) 
			else: point.modulate = Color(.6,.6,.6,1)
	animate_item_list( current_carrousel_item )

func animate_item_list(cr):
	var desX = GC.GAME_SIZE.x/2 - current_carrousel_item.rect_position.x - current_carrousel_item.rect_size.x/2
	var destine = Vector2(desX,$ItemsList.rect_position.y)
	$Tween.interpolate_property($ItemsList,"rect_position",$ItemsList.rect_position,destine,.3,Tween.TRANS_QUAD,Tween.EASE_OUT)
	$Tween.start()

func carrousel_next():
	if(carrousel_index[current_type]<PACK_DATA.size()-1): 
		carrousel_index[current_type] += 1
		update_carrousel_data()

func carrousel_back():
	if(carrousel_index[current_type]>0): 
		carrousel_index[current_type] -= 1
		update_carrousel_data()
