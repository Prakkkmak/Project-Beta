extends Marker2D

@onready var label: Label = %Label
@onready var timer: Timer = %Timer

@export var texts_to_diplay: Array[String] = []


func _ready() -> void:
	GlobalEvents.threshold_triggered.connect(_on_threshold_triggered)
	timer.timeout.connect(_on_timer_timeout)


func display_text(text: String) -> void:
	print(text)
	_assign_text_to_label(text)
	_animate_text_display()


func process_next_step() -> void:
	if texts_to_diplay.is_empty():
		timer.stop()
		label.hide()
		return
	display_text(texts_to_diplay[0])
	texts_to_diplay.remove_at(0)
	if timer.is_stopped(): 
		timer.start()


func _assign_text_to_label(text: String) -> void:
	label.text = text


func _animate_text_display() -> void:
	label.show()
 

func _on_threshold_triggered(event_treshold: EventThreshold) -> void:
	if !event_treshold is TextEventThreshold:
		return
	var text_event_treshold: TextEventThreshold = event_treshold as TextEventThreshold
	texts_to_diplay.append_array(text_event_treshold.texts)
	process_next_step()


func _on_timer_timeout() -> void:
	print("timeout")
	process_next_step()


