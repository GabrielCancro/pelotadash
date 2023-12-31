extends Control

var data
var type
var selected
# Called when the node enters the scene tree for the first time.
func _ready():
	set_selected(false,true)

func set_data(current_type, pack_name):
	data = DG.PACK_DATA[current_type][pack_name]
	type = current_type
	data.name = pack_name
	data.type = current_type
	var getted = DG.PLAYER_DATA.packs_getted.has(pack_name)
	$lb_red.text = ""
	if type=="biomes":
		$lb_title.text = "BIOME "+data.biome.to_upper()+" PACK"
		$lb_desc.text = "Add new challenges to this biome."
		if data.req_pack>0: $lb_red.text += "Need "+str(data.req_pack)+" biome packs"
		if "J" in data.req_power: $lb_red.text += "\nNeed JUMP power up!"
	elif type=="powers":
		$lb_title.text = data.name.to_upper()
		$lb_desc.text = data.desc
	elif type=="skins":
		$lb_title.text = data.name.to_upper()
		$lb_desc.text = "Change your look!"
	elif type=="musics":
		$lb_title.text = data.name.to_upper()
		$lb_desc.text = "Add new great music to play"
		
	$lb_price.text = "$"+str(data.price)
	$lb_price.visible = !getted
	$lb_getted.visible = getted
	$TextureRect.texture = DG.IMAGES[data.img]

func set_selected(val,forced=false):
	if !forced && val==selected: return
	var time = .3
	if forced: time = 0.01
	selected = val
	if selected == true:
		$Tween.interpolate_property(self,"modulate",modulate,Color(1,1,1,1),time)
		$Tween.interpolate_property(self,"rect_position",rect_position,rect_position+Vector2(0,-25),time)
	else:
		$Tween.interpolate_property(self,"modulate",modulate,Color(.3,.3,.3,1),time)
		$Tween.interpolate_property(self,"rect_position",rect_position,rect_position+Vector2(0,+25),time)
	$Tween.start()

func get_data():
	return data

func refresh_data():
	set_data(data.type,data.name)
