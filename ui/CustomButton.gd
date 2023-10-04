extends Button
tool

func _ready(): 
	if !Engine.editor_hint:
		connect("button_down",self,"on_click")
		$Label.text = text

func _process(delta):
	if Engine.editor_hint: _tool_process(delta)

func on_click():
	$Tween.interpolate_property(self,"modulate",Color(.5,.5,.5,1),Color(1,1,1,1),.2)
	$Tween.start()
	print("CLICK")

func _tool_process(delta):
	$Label.text = text
