extends Button
tool

var is_selected = false

func _ready(): 
	if !Engine.editor_hint:
		connect("button_down",self,"on_click")
		$Label.text = text
		set_selected(false)

func _process(delta):
	if Engine.editor_hint: _tool_process(delta)

func on_click():
	$Tween.interpolate_property(self,"modulate",Color(.5,.5,.5,1),Color(1,1,1,1),.2)
	$Tween.start()
	print("CLICK")

func set_selected(val):
	is_selected = val
	if is_selected: $ColorRect.color = Color(.9,1,.9,1)
	else: $ColorRect.color = Color(.15,.20,.15,1)

func _tool_process(delta):
	$Label.text = text
