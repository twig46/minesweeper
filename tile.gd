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

func get_neighbours() -> Array:
	var neigbours: Array
	for c in get_parent().get_children():
		if abs(c.index.x - index.x) <= 1 and abs(c.index.y - index.y) <= 1:
			neigbours.append(c)
	return neigbours

func _on_pressed() -> void:
	await get_parent().clicked(index, self)
	texture_normal = make_atlas(index.z * 17)
