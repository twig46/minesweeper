extends Sprite2D

func _ready():
	if OS.has_feature("web"):
		visible = true

func _process(delta: float) -> void:
	scale.x = get_viewport_rect().size.x / 1080
	scale.y = get_viewport_rect().size.y / 607
