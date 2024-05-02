class_name QuestGenerator
extends Node2D


@export var quest_display_scene: PackedScene 


var quest_spawns: Array[Node2D] = []


func _ready() -> void:
	GlobalEvents.threshold_triggered.connect(_on_threshold_triggered)
	var nodes: Array[Node] = get_tree().get_nodes_in_group("quest_spawn")
	for node: Node in nodes:
		if node is Node2D:
			quest_spawns.append(node as Node2D)


func add_quest(quest: Quest) -> void:
	if !quest_display_scene:
		return
	if !quest:
		return
	var quest_display: QuestDisplay = quest_display_scene.instantiate()
	add_child(quest_display)
	quest_display.global_position = quest_spawns.pick_random().global_position
	quest_display.assign_quest(quest)
	Score.changed.connect(quest._on_score_changed)


func _on_threshold_triggered(event_treshold: EventThreshold) -> void:
	if !event_treshold is QuestEventThreshold:
		return
	var quest_event_treshold: QuestEventThreshold = event_treshold as QuestEventThreshold
	add_quest(quest_event_treshold.quest)
