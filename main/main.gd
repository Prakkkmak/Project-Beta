class_name Main
extends Node

@export_file("*.tscn") var end_screen_file_path: String = "res://screens/end_screen/end_screen.tscn"


@export_range(0,1000) var score: int = 0


@onready var main_button: TextureButton = %MainButton
@onready var give_up_button: TextureButton = %GiveUpButton
@onready var score_label: Label = %ScoreLabel
@onready var quest_generator: QuestGenerator = $QuestGenerator


func _ready() -> void:
	give_up_button.pressed.connect(_on_give_up_button_pressed)
	main_button.pressed.connect(_on_main_button_pressed)


func _increment_score(delta: int = 1) -> void:
	score += delta
	_update_score_label()
	if score == 1:
		var quest: Quest = Quest.new()
		quest.max_value = 20
		quest.text = "Clic the button"
		main_button.pressed.connect(quest.progress)
		quest_generator.add_quest(quest)


func _update_score_label() -> void:
	score_label.text = "Score: " + str(score)


func _on_main_button_pressed() -> void:
	_increment_score()


func _on_give_up_button_pressed() -> void:
	if !end_screen_file_path:
		push_warning("No end screen file path set")
		return
	print("Player give up")
	get_tree().change_scene_to_file(end_screen_file_path)
