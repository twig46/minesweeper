extends Control

var segs:Dictionary = {"1": 0, "2": 14, "3": 28, "4": 42, "5": 56, "6": 70, "7": 84, "8": 98, "9": 112, "0": 126, '-': 140, ' ': 154}
var time = 0
var running = true

func _ready() -> void:
	start()

func _exit_tree() -> void:
	running = false

func start():
	await get_tree().process_frame
	var minegrid = get_node_or_null("/root/main/sweeper/minegrid")
	while running:
		if minegrid == null:
			break
		while minegrid.first == true and running:
			await get_tree().process_frame
		while minegrid.curstate == "normal" and running:
			await get_tree().create_timer(1).timeout
			time += 1
			update()
		break

func update():
	var timearray = str(time).split("")
	for t in range(len(timearray)):
		var char_key = timearray[len(timearray) - 1 - t]
		var digit = get_node(str(t + 1)) as Sprite2D
		digit.region_rect.position.x = segs[char_key]
	for t in range(3 - len(timearray)):
		var digit = get_node(str(len(timearray) + t + 1)) as Sprite2D
		digit.region_rect.position.x = segs[" "]
