extends Node


signal threshold_triggered(event_treshold: EventThreshold)
signal quest_completed(quest_id: String)

func trigger_treshold(event_treshold: EventThreshold) -> void:
	threshold_triggered.emit(event_treshold)


func complete_quest(quest_id: String) -> void:
	quest_completed.emit(quest_id)
