extends CanvasLayer

@export_file("*.tscn") var main_screen_file_path: String = "res://main/main.tscn"
@export_file("*.tscn") var leaderboard_screen_file_path: String = "res://screens/leaderboard_screen/leaderboard_screen.tscn"

@onready var start_button: TextureButton = %StartButton
@onready var leaderboard_button: TextureButton = %LeaderboardButton


func _ready() -> void:
	start_button.pressed.connect(_on_start_button_pressed)
	leaderboard_button.pressed.connect(_on_leaderboard_button_pressed)


func _on_start_button_pressed() -> void:
	if !main_screen_file_path:
		push_warning("No end screen file path set")
		return
	get_tree().change_scene_to_file(main_screen_file_path)


func _on_leaderboard_button_pressed() -> void:
	if !leaderboard_screen_file_path:
		push_warning("No end screen file path set")
		return
	get_tree().change_scene_to_file(leaderboard_screen_file_path)
