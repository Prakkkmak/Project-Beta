extends Node


signal threshold_triggered(event_treshold: EventThreshold)


func trigger_treshold(event_treshold: EventThreshold) -> void:
	threshold_triggered.emit(event_treshold)
