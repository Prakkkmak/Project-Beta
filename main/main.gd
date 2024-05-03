class_name Main
extends Node

@export_file("*.tscn") var end_screen_file_path: String = "res://screens/end_screen/end_screen.tscn"
@export_range(0,1000) var starting_score: int = 0

@export var forbidden_scores: Array[int] = [518, 1222, 2148, 5123, 5134]
@export var wait_time_seconds: float = 10
@export var broken_time_secondes: float = 120

@onready var french_button: Button = %FrenchButton
@onready var english_button: Button = %EnglishButton

@onready var main_button: MainButton = %MainButton
@onready var give_up_button: GiveUpButton = %GiveUpButton
@onready var quest_generator: QuestGenerator = $QuestGenerator


func _ready() -> void:
	if !give_up_button:
		return
	give_up_button.released.connect(_on_give_up_button_pressed)
	Score.changed.connect(_on_score_changed)
	Score.set_score(starting_score)


func _on_give_up_button_pressed() -> void:
	if !end_screen_file_path:
		push_warning("No end screen file path set")
		return
	get_tree().change_scene_to_file(end_screen_file_path)
	

func _on_french_button_pressed() -> void:
	TranslationServer.set_locale("fr")

func _on_english_button_pressed() -> void:
	TranslationServer.set_locale("en")


func _on_score_changed(old_score: int, new_score: int) -> void:
	if forbidden_scores.find(new_score) >= 0:
		print("Forbidden")
		get_tree().create_timer(wait_time_seconds).timeout.connect(_on_wait_button_timer_timeout.bind(new_score))
	if forbidden_scores.find(old_score) >= 0:
		main_button.broke_button()
		GlobalEvents.send_messages([
			"NOOON !",
			"Je t'avais dis de t'arrêter là",
			"Maintenant le bouton est cassé...",
			"Tu vas devoir attendre quelques secondes avant que je le répare"
		])
		get_tree().create_timer(broken_time_secondes).timeout.connect(_on_broken_button_timer_timeout)
	


func _on_wait_button_timer_timeout(score_forbidden: int) -> void:
	forbidden_scores.erase(score_forbidden)
	if Score.score == score_forbidden:
		GlobalEvents.send_messages([
			"Tu peux continuer."
		])

func _on_broken_button_timer_timeout() -> void:
	main_button.repair_button()
	GlobalEvents.send_messages([
			"Voila ! Le bouton est réparé.",
			"Tapote le et ça devrais revenir !",
			"Les instructions sont très importantes, ne l'oublie pas"
		])
