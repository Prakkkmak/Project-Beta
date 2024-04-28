class_name QuestDisplay
extends VBoxContainer


@export var quest: Quest


const POP_IN: String = "pop_in"
const POP_OUT: String = "pop_out"


@onready var quest_label: Label = %QuestLabel
@onready var quest_progress_bar: ProgressBar = %QuestProgressBar
@onready var animation_player: AnimationPlayer = %AnimationPlayer


func _init() -> void:
	update_display()


func assign_quest(init_quest: Quest) -> void:
	quest = init_quest
	quest.progressed.connect(_on_quest_progressed)
	quest.changed.connect(_on_quest_progressed)
	quest.completed.connect(_on_quest_completed)
	update_display()
	animation_player.play(POP_IN)


func update_display() -> void:
	if quest:
		quest_label.text = quest.text
		quest_progress_bar.value = quest.value
		quest_progress_bar.max_value = quest.max_value


func remove_display() -> void:
	animation_player.play(POP_OUT)
	animation_player.animation_finished.connect(_on_animation_remove_finished)


func _on_animation_remove_finished(anim: String) -> void:
	queue_free()


func _on_quest_progressed() -> void:
	update_display()


func _on_quest_completed() -> void:
	remove_display()
