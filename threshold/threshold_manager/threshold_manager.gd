@tool
class_name ThresholdManager

extends Node

@export var event_thresholds: ResourceGroup

var _event_thresholds: Array[EventThreshold] = []

func _ready() -> void:
	event_thresholds.load_all_into(_event_thresholds)
	_event_thresholds.sort_custom(_compare_thresholds)
	Score.changed.connect(_on_score_changed)


func _compare_thresholds(a: EventThreshold, b: EventThreshold) -> bool:
	return a.score < b.score


func _on_score_changed(old_score: int, new_score: int) -> void:
	for event_threshold: EventThreshold in _event_thresholds:
		if event_threshold.score > old_score and event_threshold.score <= new_score:
			GlobalEvents.trigger_treshold(event_threshold)
			print("Threshold triggered: %s" % [event_threshold]) 
		if event_threshold.score > new_score:
			return
