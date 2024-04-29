extends Label

@export var base_text: String = "Score: "

func _ready() -> void:
	Score.changed.connect(_on_score_changed)


func _on_score_changed(old_score: int, new_score: int) -> void:
	text = base_text + str(new_score)
