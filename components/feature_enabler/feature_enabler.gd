extends Node


@export var base_feature_enabler: FeatureEnablerThreshold


@export var main_button: Node2D
@export var main_button_indicator: Node2D
@export var give_up_button: Node2D
@export var give_up_button_indicator: Node2D
@export var score_display: Node2D
@export var trash_bin: Node2D
@export var light: Node2D


@onready var features: Dictionary = {
	"main_button": main_button,
	"main_button_indicator": main_button_indicator,
	"give_up_button": give_up_button,
	"give_up_button_indicator": give_up_button_indicator,
	"score_display": score_display,
	"trash_bin": trash_bin,
	"light": light,
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
			node_to_enable.show()
	for disabled_feature: String in feature_enabler_threshold.to_disable_list:
		print("disable " + disabled_feature)
		if features.has(disabled_feature) && features[disabled_feature] is Node2D:
			var node_to_disable: Node2D = features[disabled_feature]
			node_to_disable.hide()


func _on_threshold_triggered(event_treshold: EventThreshold) -> void:
	if !(event_treshold is FeatureEnablerThreshold):
		return
	var feature_enabler_threshold: FeatureEnablerThreshold = event_treshold as FeatureEnablerThreshold
	enable_features(feature_enabler_threshold)
	
