extends Node


@export var base_feature_enabler: FeatureEnablerThreshold


@export var main_button: Node2D
@export var main_button_indicator: Node2D
@export var give_up_button: Node2D
@export var give_up_button_indicator: Node2D
@export var score_display: Node2D
@export var trash_bin: Node2D
@export var name_field: Node2D
@export var light: Node2D

@onready var appear_audio_stream_player: AudioStreamPlayer2D = $AppearAudioStreamPlayer


@onready var features: Dictionary = {
	"main_button": main_button,
	"main_button_indicator": main_button_indicator,
	"give_up_button": give_up_button,
	"give_up_button_indicator": give_up_button_indicator,
	"score_display": score_display,
	"trash_bin": trash_bin,
	"light": light,
	"name_field": name_field
}


func _ready() -> void:
	GlobalEvents.threshold_triggered.connect(_on_threshold_triggered)
	disable_all()
	if base_feature_enabler:
		enable_features(base_feature_enabler)


func disable_all() -> void:
	var elements: Array[Variant] = features.values()
	for element: Variant in elements:
		if element && element is Node2D:
			var node: Node2D = element
			node.hide()


func enable_features(feature_enabler_threshold: FeatureEnablerThreshold) -> void:
	for enabled_feature: String in feature_enabler_threshold.to_enable_list:
		print("enable " + enabled_feature)
		if features.has(enabled_feature) && features[enabled_feature] is Node2D:
			var node_to_enable: Node2D = features[enabled_feature]
			show_element(node_to_enable)
	for disabled_feature: String in feature_enabler_threshold.to_disable_list:
		print("disable " + disabled_feature)
		if features.has(disabled_feature) && features[disabled_feature] is Node2D:
			var node_to_disable: Node2D = features[disabled_feature]
			node_to_disable.hide()


func show_element(node: Node2D) -> void:
	var tween: Tween = get_tree().create_tween()
	var final_scale: Vector2 = node.scale
	node.scale = Vector2.ZERO
	tween.tween_property(node, "scale", final_scale, 1)
	tween.tween_callback(node.show)
	appear_audio_stream_player.global_position = node.global_position
	appear_audio_stream_player.play()

func _on_threshold_triggered(event_treshold: EventThreshold) -> void:
	if !(event_treshold is FeatureEnablerThreshold):
		return
	var feature_enabler_threshold: FeatureEnablerThreshold = event_treshold as FeatureEnablerThreshold
	enable_features(feature_enabler_threshold)
	
