extends Resource
class_name Quest

signal progressed
signal completed

@export var text: String
@export var max_value: int


var value: int = 0


func progress(delta: int = 1) -> void:
	print("Quest progression " + str(delta))
	value += delta
	print("Quest progression " +  str(value))
	if value >= max_value:
		completed.emit()
	else:
		progressed.emit()
