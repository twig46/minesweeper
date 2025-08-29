extends SpinBox

func _process(delta: float) -> void:
	value = clamp(value, 0, get_node("/root/main/numbers/gridx").value * get_node("/root/main/numbers/gridy").value - 9)
