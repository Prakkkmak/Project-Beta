class_name QuestPanel
extends PanelContainer


@export var quest_display_scene: PackedScene 


@onready var quest_lines: VBoxContainer = %QuestLines


func add_quest(quest: Quest) -> void:
	if !quest_display_scene:
		return
	var quest_display: QuestDisplay = quest_display_scene.instantiate()
	quest_lines.add_child(quest_display)
	quest_display.assign_quest(quest)
