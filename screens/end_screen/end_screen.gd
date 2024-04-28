extends CanvasLayer

@export_file("*.tscn") var title_screen_file_path: String = "res://screens/title_screen/title_screen.tscn"

@onready var restart_button: Button = %RestartButton

func _ready() -> void:
	restart_button.pressed.connect(_on_restart_button_pressed)


func _on_restart_button_pressed() -> void:
	if !title_screen_file_path:
		push_warning("No title screen file path set")
		return
	get_tree().change_scene_to_file(title_screen_file_path)
