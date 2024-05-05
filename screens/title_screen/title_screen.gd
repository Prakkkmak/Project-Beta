extends CanvasLayer

@export_file("*.tscn") var main_screen_file_path: String = "res://main/main.tscn"
@export_file("*.tscn") var leaderboard_screen_file_path: String = "res://screens/leaderboard_screen/leaderboard_screen.tscn"

@onready var start_button: TextureButton = %StartButton
@onready var leaderboard_button: TextureButton = %LeaderboardButton
@onready var en_button: TextureButton = %EnButton
@onready var fr_button: TextureButton = %FrButton


func _ready() -> void:
	start_button.pressed.connect(_on_start_button_pressed)
	leaderboard_button.pressed.connect(_on_leaderboard_button_pressed)
	en_button.pressed.connect(_on_english_button_pressed)
	fr_button.pressed.connect(_on_french_button_pressed)
	TranslationServer.set_locale("en")


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


func _on_french_button_pressed() -> void:
	TranslationServer.set_locale("fr")
	en_button.button_pressed = false


func _on_english_button_pressed() -> void:
	TranslationServer.set_locale("en")
	fr_button.button_pressed = false
