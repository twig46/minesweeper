extends GridContainer

@export var gridsize:int = 3

var example:TextureButton

func _ready() -> void:
	example = $tile
	spawn_mines()

func spawn_mines():
	var index:= Vector3(0, 0, 2)
	columns = gridsize
	for i in range(pow(gridsize, 2)):
		var newbutt = example.duplicate()
		newbutt.index = index
		add_child(newbutt)
		index.x += 1
		index.z = randi_range(0, 8)
		if index.x >= gridsize:
			index.y += 1
			index.x = 0
	example.queue_free()

func clicked(buttindex: Vector3):
	pass
