extends Resource
class_name Quest

signal progressed
signal completed

@export var text: String
@export var max_value: int


var value: int = 0


func progress(delta: int = 1) -> void:
	value += delta
	if value >= max_value:
		completed.emit()
	else:
		progressed.emit()


func _on_score_changed(old_score: int, new_score: int) -> void:
	progress(new_score - old_score)
