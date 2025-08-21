extends GridContainer

@export var gridsize:Vector2 = Vector2(6, 6)
@export var minecount:int = 3

var example:TextureButton
var bombs := []
var first := true

func _ready() -> void:
	example = $tile
	spawn_grid()

func spawn_grid():
	var index:= Vector3(0, 0, 1)
	columns = gridsize.x
	size.x *= (gridsize.x / gridsize.y)
	for i in range(gridsize.x * gridsize.y):
		var newbutt = example.duplicate()
		newbutt.index = index
		add_child(newbutt)
		index.x += 1
		if index.x >= gridsize.x:
			index.y += 1
			index.x = 0
	example.queue_free()

func clicked(tile: Control) -> void:
	print(tile.index)
	if first:
		first = false
		generate()
		for n in tile.get_neighbours():
			n.index.z = 0
	elif tile.index.z != 13:
		tile.index.z = 0
		for n in tile.get_neighbours():
			if n.index.z == 13:
				tile.index.z += 1
	if tile.index.z == 0:
		print("0")
		for n in tile.get_neighbours():
			if !n.revealed:
				n._on_pressed()
	return


func generate():
	var remaining = minecount
	while remaining > 0:
		var child = get_children().pick_random()
		if child.index.z != 0:
			child.index.z = 13
			bombs.append(child)
			remaining -= 1
