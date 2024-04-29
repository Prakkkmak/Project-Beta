class_name Score
extends Node


signal changed(old_value: int, new_value: int)

@export var main_button: MainButton
@export var score: int = 0


func _ready() -> void:
	if main_button:
		main_button.released.connect(_on_main_button_released)


func change_score(delta: int = 1) -> void:
	if delta == 0:
		return
	score += delta
	changed.emit(score - delta, score)


func _on_main_button_released() -> void:
	change_score(1)
