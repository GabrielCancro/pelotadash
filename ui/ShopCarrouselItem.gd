extends Control

var data
var selected
# Called when the node enters the scene tree for the first time.
func _ready():
	set_selected(false,true)

func set_data(_data):
	data = _data
	$lb_title.text = "BIOME "+data.biome.to_upper()+" PACK"
	$lb_price.text = "$"+str(data.price)
	$lb_price.visible = !data.getted
	$lb_getted.visible = data.getted
	$lb_desc.text = "Add new challenges to this biome."
	$lb_red.text = ""
	if data.req_pack>0: $lb_red.text += "Need "+str(data.req_pack)+" biome packs"
	if "J" in data.req_power: $lb_red.text += "\nNeed JUMP power up!"

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
