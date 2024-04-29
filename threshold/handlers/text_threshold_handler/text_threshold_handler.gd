extends Node


func _ready() -> void:
	GlobalEvents.threshold_triggered.connect(_on_threshold_triggered)


func _on_threshold_triggered(event_treshold: EventThreshold) -> void:
	if !event_treshold is TextEventThreshold:
		return
	var text_event_treshold: TextEventThreshold = event_treshold as TextEventThreshold
	print(text_event_treshold.texts_to_display)
