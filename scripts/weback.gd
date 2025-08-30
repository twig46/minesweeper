extends Sprite2D

func _ready():
	if OS.has_feature("web"):
		visible = true
