extends Control

var segs:Dictionary = {"1": 0, "2": 14, "3": 28, "4": 42, "5": 56, "6": 70, "7": 84, "8": 98, "9": 112, "0": 126, '-': 140, ' ': 154}
var orimines = Global.minecount
var curmines = 0

func _ready() -> void:
	update(orimines)

func update(mines):
	curmines += mines
	var minearray = str(curmines).split("")
	for m in range(len(minearray)):
		var char_key = minearray[len(minearray) - 1 - m]
		var digit = get_node(str(m + 1)) as Sprite2D
		digit.region_rect.position.x = segs[char_key]
	for m in range(3 - len(minearray)):
		var digit = get_node(str(len(minearray) + m + 1)) as Sprite2D
		digit.region_rect.position.x = segs[" "]
