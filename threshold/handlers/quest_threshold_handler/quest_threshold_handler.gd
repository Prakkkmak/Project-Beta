extends Node


@export var quest_generator: QuestGenerator

func _ready() -> void:
	GlobalEvents.threshold_triggered.connect(_on_threshold_triggered)

func _on_threshold_triggered(event_treshold: EventThreshold) -> void:
	if !quest_generator:
		return
	if !event_treshold is QuestEventThreshold:
		return
	var quest_event_treshold: QuestEventThreshold = event_treshold as QuestEventThreshold
	quest_generator.add_quest(quest_event_treshold.quest)
