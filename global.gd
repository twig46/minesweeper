extends Node

var gridsize := Vector2(16, 16)
var minecount := 40

func _ready():
	retainer()

func retainer():
	while true:
		print("also reload")
		await get_node("/root/main/sweeper/minegrid").reload
		get_node("/root/main/gridx").value = gridsize.x
		get_node("/root/main/gridy").value = gridsize.y
		get_node("/root/main/mines").value = minecount
		print(get_node("/root/main/mines").value)
		print(get_node("/root/main/gridx").value)
		print(get_node("/root/main/gridy").value)
	print("fail")
