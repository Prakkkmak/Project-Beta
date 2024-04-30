extends Marker2D

#Reference au label (Avec le %)

func _ready() -> void:
	GlobalEvents.threshold_triggered.connect(_on_threshold_triggered)

#TODO Fonction publique pour affiher un texte ((comme display_text(text: String))
#TODO Assign text to Text label
#TODO Text display fais sa tambouille pour afficher le texte

func _on_threshold_triggered(event_treshold: EventThreshold) -> void:
	if !event_treshold is TextEventThreshold:
		return
	var text_event_treshold: TextEventThreshold = event_treshold as TextEventThreshold
	print(text_event_treshold.texts_to_display)
	#TODO Afficher le texte grace a la fonction

