extends Marker2D


@export var texts_to_diplay: Array[String] = []
@export var time_per_character: float = 0.05

@onready var label: Label = %Label
@onready var timer: Timer = %Timer
@onready var animation_player: AnimationPlayer = %AnimationPlayer


const ANIM_FADE_IN_NAME: String = "fade_in"
const ANIM_FADE_OUT_NAME: String = "fade_out"


var text_displayed: bool = false


func _ready() -> void:
	GlobalEvents.threshold_triggered.connect(_on_threshold_triggered)
	timer.timeout.connect(_on_timer_timeout)
	animation_player.animation_finished.connect(_on_animation_finished)


func process_next_step() -> void:
	if text_displayed || texts_to_diplay.is_empty():
		return
	display_text(texts_to_diplay[0])
	texts_to_diplay.remove_at(0)


func display_text(text: String) -> void:
	print("Display " + text)
	text_displayed = true
	label.text = text
	timer.wait_time = tr(text).length() * 0.07
	print("Timer time : " + str(timer.wait_time))
	animation_player.play(ANIM_FADE_IN_NAME)


func _on_timer_timeout() -> void:
	animation_player.play(ANIM_FADE_OUT_NAME)
	process_next_step()


func _on_animation_finished(name: String) -> void:
	if name == ANIM_FADE_IN_NAME:
		timer.start()
	if name == ANIM_FADE_OUT_NAME:
		timer.stop()
		text_displayed = false
		process_next_step()
 

func _on_threshold_triggered(event_treshold: EventThreshold) -> void:
	if !event_treshold is TextEventThreshold:
		return
	var text_event_treshold: TextEventThreshold = event_treshold as TextEventThreshold
	texts_to_diplay.append_array(text_event_treshold.texts)
	process_next_step()
