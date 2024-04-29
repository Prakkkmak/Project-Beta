class_name Main
extends Node

@export_file("*.tscn") var end_screen_file_path: String = "res://screens/end_screen/end_screen.tscn"


@export_range(0,1000) var score: int = 0


@onready var give_up_button: GiveUpButton = %GiveUpButton
@onready var quest_generator: QuestGenerator = $QuestGenerator


func _ready() -> void:
	if !give_up_button:
		return
	give_up_button.pressed.connect(_on_give_up_button_pressed)


func _increment_score(delta: int = 1) -> void:
	score += delta

func _on_give_up_button_pressed() -> void:
	if !end_screen_file_path:
		push_warning("No end screen file path set")
		return
	get_tree().change_scene_to_file(end_screen_file_path)
