extends Window

var is_dragging = false
var mouse_offset

func _on_close() -> void:
	hide()

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
