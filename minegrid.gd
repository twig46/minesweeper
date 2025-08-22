extends GridContainer

@export var gridsize:Vector2 = Vector2(6, 6)
@export var minecount:int = 3

var example:TextureButton
var bombs := []
var first := true
var remaining_tiles := []

func _ready() -> void:
	example = $tile
	spawn_grid()

func spawn_grid():
	var index:= Vector3(0, 0, 1)
	columns = gridsize.x
	size.y *= (gridsize.y / gridsize.x)
	for i in range(gridsize.x * gridsize.y):
		var newbutt = example.duplicate()
		newbutt.index = index
		remaining_tiles.append(newbutt)
		add_child(newbutt)
		index.x += 1
		if index.x >= gridsize.x:
			index.y += 1
			index.x = 0
	example.queue_free()

func clicked(tile: Control, clear:bool = false) -> void:
	var remaining_bombs := []
	remaining_tiles.erase(tile)
	for r in remaining_tiles:
		if bombs.has(r):
			remaining_bombs.append(r)
	if remaining_tiles == remaining_bombs:
		print(remaining_tiles)
		for r in remaining_tiles.duplicate():
			r.flag()
	if tile.index.z == 14:
		print("lose")
	if !clear:
		if first:
			first = false
			generate()
			for n in tile.get_neighbours():
				n.index.z = 0
		elif tile.index.z != 14:
			tile.index.z = 0
			for n in tile.get_neighbours():
				if n.index.z == 14:
					tile.index.z += 1
		if tile.index.z == 0:
			for n in tile.get_neighbours():	
				if !n.revealed:
					n._on_pressed()
		if !tile.flagged:
			tile.texture_normal = tile.make_atlas(tile.index.z * 17)
	else:
		var flags:int = 0
		for n in tile.get_neighbours():
			if n.flagged == true:
				flags += 1
		if flags == tile.index.z:
			for n in tile.get_neighbours():
				if !n.revealed and !n.flagged:
					n._on_pressed()
	return


func generate():
	var remaining = minecount
	while remaining > 0:
		var child = get_children().pick_random()
		if child.index.z != 0:
			child.index.z = 14
			bombs.append(child)
			remaining -= 1

func win_lose():
	var flags := 0
	for b in bombs:
		if b.flagged:
			flags += 1
	if flags == minecount:
		print("win")
		
