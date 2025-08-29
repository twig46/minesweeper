extends Window
var is_dragging = false
var mouse_offset

func _ready() -> void:
	if self == get_node("/root/main/grid"):
		size.x = $sweeper.size.x + 80

func _enter_tree() -> void:
	if Global.win_position.has(name):
		position = Global.win_position[name]

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT:
		if event.is_pressed():
			if get_visible_rect().has_point(event.position):
				is_dragging = true
				mouse_offset = event.position
		else:
			is_dragging = false
	if event is InputEventMouseMotion and is_dragging:
		position += Vector2i(event.position - mouse_offset)
	if self == get_node("/root/main/grid"):
		get_node("/root/main/facewin/face")._input(event)

func _on_close() -> void:
	get_tree().quit()

func _exit_tree() -> void:
	Global.win_position[name] = position
