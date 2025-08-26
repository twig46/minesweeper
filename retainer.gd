extends Control

func _ready():
	retainer()

func retainer():
	$gridx.value = Global.gridsize.x
	$gridy.value = Global.gridsize.y
	$mines.value = Global.minecount
