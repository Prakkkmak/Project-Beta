class_name QuestGenerator
extends Marker2D


@export var quest_display_scene: PackedScene 


func add_quest(quest: Quest) -> void:
	if !quest_display_scene:
		return
	var quest_display: QuestDisplay = quest_display_scene.instantiate()
	add_child(quest_display)
	quest_display.assign_quest(quest)
	Score.changed.connect(quest._on_score_changed)
