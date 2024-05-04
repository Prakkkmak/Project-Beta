class_name Main
extends Node

@export_file("*.tscn") var leaderboard_screen_file_path: String = "res://screens/leaderboard_screen/leaderboard_screen.tscn"
@export_range(0,10000) var starting_score: int = 0

@export var forbidden_scores: Array[int] = [518]
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
	if !leaderboard_screen_file_path:
		push_warning("No end screen file path set")
		return
	Leaderboard.push_new_score(Score.score)
	get_tree().change_scene_to_file(leaderboard_screen_file_path)


func _on_score_changed(old_score: int, new_score: int) -> void:
	if forbidden_scores.find(new_score) >= 0:
		get_tree().create_timer(wait_time_seconds).timeout.connect(_on_wait_button_timer_timeout.bind(new_score))
	if forbidden_scores.find(old_score) >= 0:
		main_button.broke_button()
		GlobalEvents.send_messages([
			"PLEASE_STOP_TXT_1",
			"PLEASE_STOP_TXT_2",
			"PLEASE_STOP_TXT_3",
			"PLEASE_STOP_TXT_4"
		])
		get_tree().create_timer(broken_time_secondes).timeout.connect(_on_broken_button_timer_timeout)


func _on_wait_button_timer_timeout(score_forbidden: int) -> void:
	forbidden_scores.erase(score_forbidden)
	if Score.score == score_forbidden:
		GlobalEvents.send_messages([
			"PLEASE_STOP_TXT_SUCCESS_CONTINUE_1"
		])

func _on_broken_button_timer_timeout() -> void:
	main_button.repair_button()
	GlobalEvents.send_messages([
			"PLEASE_STOP_TXT_FAIL_CONTINUE_1",
			"PLEASE_STOP_TXT_FAIL_CONTINUE_2",
			"PLEASE_STOP_TXT_FAIL_CONTINUE_3"
		])
