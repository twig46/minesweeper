extends Control

func _ready():
	retainer()

func retainer():
	$numbers/gridx.value = Global.gridsize.x
	$numbers/gridy.value = Global.gridsize.y
	$numbers/mines.value = Global.minecount

func _input(event: InputEvent) -> void:
	if event is InputEventMouse:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MINIMIZED)
