extends Control

func _ready():
	retainer()

func retainer():
	$numbers/gridx.value = Global.gridsize.x
	$numbers/gridy.value = Global.gridsize.y
	$numbers/mines.value = Global.minecount
