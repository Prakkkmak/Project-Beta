class_name QuestGenerator
extends Marker2D


@export var quest_display_scene: PackedScene 

func _ready() -> void:
	GlobalEvents.threshold_triggered.connect(_on_threshold_triggered)


func add_quest(quest: Quest) -> void:
	if !quest_display_scene:
		return
	if !quest:
		return
	var quest_display: QuestDisplay = quest_display_scene.instantiate()
	add_child(quest_display)
	quest_display.assign_quest(quest)
	Score.changed.connect(quest._on_score_changed)


func _on_threshold_triggered(event_treshold: EventThreshold) -> void:
	if !event_treshold is QuestEventThreshold:
		return
	var quest_event_treshold: QuestEventThreshold = event_treshold as QuestEventThreshold
	add_quest(quest_event_treshold.quest)
