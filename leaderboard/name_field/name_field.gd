extends Marker2D


@onready var text_edit: TextEdit = %TextEdit

func _ready() -> void:
	text_edit.text_changed.connect(_on_text_changed)


func _on_text_changed(new_text: String) -> void:
	Leaderboard.set_current_name(new_text)
