extends TextureButton

var index: Vector3 = Vector3.ZERO
var one := preload("res://1.tres")

func _ready() -> void:
	texture_normal = make_atlas(9 * 17)

	texture_pressed = make_atlas(0)

	pressed.connect(_on_pressed)

func make_atlas(x: int) -> AtlasTexture:
	var atlas: AtlasTexture = one.duplicate(true)
	atlas.region = Rect2(Vector2(x, 49), atlas.region.size)
	return atlas

func _on_pressed() -> void:
	await get_parent().clicked(index, self)
	texture_normal = make_atlas(index.z * 17)
