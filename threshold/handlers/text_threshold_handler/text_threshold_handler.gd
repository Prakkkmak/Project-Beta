extends Node


#TODO Referencer le TextDisplay


func _ready() -> void:
	GlobalEvents.threshold_triggered.connect(_on_threshold_triggered)


func _on_threshold_triggered(event_treshold: EventThreshold) -> void:
	if !event_treshold is TextEventThreshold:
		return
	var text_event_treshold: TextEventThreshold = event_treshold as TextEventThreshold
	print(text_event_treshold.texts_to_display)
	#TODO Assign text to Text display
	#Text display a une fonction pour afficher le texte (comme display_text(text: String))
	#Text display fais sa tambouille pour afficher le texte
