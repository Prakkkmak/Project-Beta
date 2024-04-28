extends CanvasLayer

@export_file("*.tscn") var end_screen_file_path: String = "res://scenes/main/main.tscn"

@onready var start_button: Button = %StartButton


func _ready() -> void:
	start_button.pressed.connect(_on_start_button_pressed)


func _on_start_button_pressed() -> void:
	if !end_screen_file_path:
		push_warning("No end screen file path set")
		return
	get_tree().change_scene_to_file(end_screen_file_path)
