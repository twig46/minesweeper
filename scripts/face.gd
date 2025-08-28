extends TextureButton

var one := preload("res://rescources/1.tres")
var curstate

@onready var minegrid = get_node("/root/main/grid/sweeper/minegrid")

func _process(delta: float) -> void:
	curstate = minegrid.curstate
	if curstate != "normal":
		if curstate == "win":
			texture_normal = make_atlas(75)
		if curstate == "lose":
			texture_normal = make_atlas(100)
		get_node("/root/main/grid/sweeper").mouse_filter = MOUSE_FILTER_STOP

func _input(event: InputEvent) -> void:
	if curstate == "normal":
		if event is InputEventMouseButton:
			if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
				texture_normal = make_atlas(50)
			else:
				texture_normal = make_atlas(0)

func make_atlas(x: int) -> AtlasTexture:
	var atlas: AtlasTexture = one.duplicate(true)
	atlas.region = Rect2(Vector2(x, 24), Vector2(24, 24))
	return atlas

#func _gui_input(event):
	#if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		#DisplayServer.window_start_drag()

func _on_reset() -> void:
	Global.gridsize = Vector2(get_node("/root/main/numbers/gridx").value, get_node("/root/main/numbers/gridy").value)
	Global.minecount = get_node("/root/main/numbers/mines").value
	get_tree().change_scene_to_file("res://scenes/main.tscn")
