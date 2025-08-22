extends TextureButton

var index: Vector3 = Vector3.ZERO
var revealed := false
var one := preload("res://1.tres")
var leftright
var flagged := false

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
	if leftright == MOUSE_BUTTON_RIGHT:
		flag()
	else:
		if !revealed:
			revealed = true
			await get_parent().clicked(self)
		else:
			await get_parent().clicked(self, true)
	get_parent().win_lose()
		

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		leftright = event.button_index

func flag():
	if !flagged and !revealed:
		flagged = true
		texture_normal = make_atlas(10 * 17)
		get_parent().remaining_tiles.erase(self)
	elif flagged and !revealed:
		flagged = false
		texture_normal = make_atlas(9 * 17)
		get_parent().remaining_tiles.append(self)
