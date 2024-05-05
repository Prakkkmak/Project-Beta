extends Marker2D


@onready var text_edit: LineEdit = %TextEdit

func _ready() -> void:
	Leaderboard.set_current_name(text_edit.text)
	text_edit.text_changed.connect(_on_text_changed)


func _on_text_changed(text_changed: String) -> void:
	print("text changed")
	print(text_changed)
	Leaderboard.set_current_name(text_changed)
