extends Node


signal changed(old_value: int, new_value: int)


@export var score: int = 0


func change_score(delta: int = 1) -> void:
	if delta == 0:
		return
	score += delta
	changed.emit(score - delta, score)

func set_score(new_score: int) -> void:
	score = new_score

func _on_main_button_released() -> void:
	change_score(1)
