extends Resource
class_name Quest

signal progressed
signal completed

@export var id: String
@export_multiline var text: String

@export var max_value: int = 0

var is_completed: bool = false
var value: int = 0


func register_to_event() -> void:
	GlobalEvents.quest_completed.connect(_on_quest_completed)


func progress(delta: int = 1) -> void:
	if is_completed:
		return
	if max_value <= 0:
		return
	value += delta
	if value >= max_value:
		is_completed = true
		completed.emit()
	else:
		progressed.emit()


func _on_score_changed(old_score: int, new_score: int) -> void:
	progress(new_score - old_score)


func _on_quest_completed(quest_id: String) -> void:
	completed.emit()
