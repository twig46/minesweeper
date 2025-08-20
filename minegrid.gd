extends GridContainer

@export var gridsize:int = 3

var example:TextureButton
var first := true
var visited := {}

func _ready() -> void:
	example = $tile
	spawn_grid()

func spawn_grid():
	var index:= Vector3(0, 0, 0)
	columns = gridsize
	for i in range(pow(gridsize, 2)):
		var newbutt = example.duplicate()
		newbutt.index = index
		if randi_range(1, 5) == 5:
			newbutt.index.z = 13
		add_child(newbutt)
		index.x += 1
		if index.x >= gridsize:
			index.y += 1
			index.x = 0
	example.queue_free()

func clicked(buttindex: Vector3, tile: Control) -> void:
	if first:
		first = false
		print(get_child_count())
		for c in get_children():
			if abs(c.index.x - buttindex.x) <= 1 and abs(c.index.y - buttindex.y) <= 1:
				c.index.z = 0
				c._on_pressed()
				return
	else:
		for c in get_children():
			if abs(c.index.x - buttindex.x) <= 1 and abs(c.index.y - buttindex.y) <= 1 and c.index.z == 13:
				tile.index.z += 1
				return
	if buttindex.z == 0:
		zero_spread(buttindex)
		return


func zero_spread(buttindex):
	var key = str(buttindex.x) + ',' + str(buttindex.y)
	if key in visited:
		return
	visited[key] = true
	
	for c in get_children():
		if abs(c.index.x - buttindex.x) <= 1 and abs(c.index.y - buttindex.y) <= 1 and c.index.z == 0:
			c._on_pressed()
			return
