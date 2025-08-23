extends GridContainer

var gridsize := Global.gridsize
var minecount := Global.minecount
var example:TextureButton
var bombs := []
var first := true
var remaining_tiles := []
var curstate: String = "normal"
var examtscn = preload("res://example.tscn")

func _ready() -> void:
	example = $tile
	spawn_grid()

func spawn_grid():
	var index:= Vector3(0, 0, 1)
	columns = gridsize.x
	get_parent().size.x *= (gridsize.x / gridsize.y)
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
		curstate = "lose"
		print("lose")
		for b in bombs:
			reveal_tile(b)
	if !clear:
		if first:
			first = false
			for n in tile.get_neighbours():
				n.index.z = 0
			generate()
		elif tile.index.z != 14:
			tile.index.z = 0
			for n in tile.get_neighbours():
				if n.index.z == 14:
					tile.index.z += 1
		if tile.index.z == 0:
			for n in tile.get_neighbours():	
				if !n.revealed:
					reveal_tile(n)
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
		if child.index.z != 0 and child.index.z != 14:
			child.index.z = 14
			bombs.append(child)
			remaining -= 1
	return

func win_lose():
	var flags := 0
	for b in bombs:
		if b.flagged:
			flags += 1
	if flags == minecount:
		curstate = "win"
		print("win")

func reveal_tile(tile: Control) -> void:
	if tile.revealed or tile.flagged:
		return
	
	var count := 14
	
	if !tile.index.z == 14:
		count = 0
		for n in tile.get_neighbours():
			if n.index.z == 14:  # bomb
				count += 1
		tile.index.z = count
	
	# Reveal tile
	tile.revealed = true
	tile.texture_normal = tile.make_atlas(count * 17)
	remaining_tiles.erase(tile)
	
	# If zero, recurse
	if count == 0:
		for n in tile.get_neighbours():
			reveal_tile(n)
