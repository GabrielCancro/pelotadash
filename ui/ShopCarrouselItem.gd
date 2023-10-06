extends Control

var data

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

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
