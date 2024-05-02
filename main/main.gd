class_name Main
extends Node

@export_file("*.tscn") var end_screen_file_path: String = "res://screens/end_screen/end_screen.tscn"


@export_range(0,1000) var starting_score: int = 0

@onready var french_button: Button = %FrenchButton
@onready var english_button: Button = %EnglishButton

@onready var give_up_button: GiveUpButton = %GiveUpButton
@onready var quest_generator: QuestGenerator = $QuestGenerator


func _ready() -> void:
	if !give_up_button:
		return
	give_up_button.released.connect(_on_give_up_button_pressed)
	Score.change_score(starting_score)


func _on_give_up_button_pressed() -> void:
	if !end_screen_file_path:
		push_warning("No end screen file path set")
		return
	get_tree().change_scene_to_file(end_screen_file_path)
	

func _on_french_button_pressed() -> void:
	TranslationServer.set_locale("fr")
	print("fr")
	updateUI()

func _on_english_button_pressed() -> void:
	TranslationServer.set_locale("en")
	print("en")
	updateUI()

func updateUI() -> void:
	pass
