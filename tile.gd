extends TextureButton

var index: Vector3 = Vector3.ZERO
var one := preload("res://1.tres")

func _ready() -> void:
	var atlas = one.duplicate()
	
	texture_pressed = atlas
	
	var tempregion = texture_pressed
	tempregion.region.position.x += (index.z)*17
	
	texture_pressed.region = tempregion.region

func _on_press() -> void:
	get_parent().clicked(index)
