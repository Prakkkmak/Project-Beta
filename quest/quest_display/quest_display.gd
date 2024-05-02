class_name QuestDisplay
extends Node2D


@export var quest: Quest


const POP_IN: String = "pop_in"
const POP_OUT: String = "pop_out"
const MARK_DONE: String = "mark_done"


@onready var quest_label: Label = %QuestLabel
@onready var quest_progress_bar: ProgressBar = %QuestProgressBar
@onready var animation_player: AnimationPlayer = %AnimationPlayer
@onready var drag_area: DragArea = %DragArea


func _ready() -> void:
	update_display()
	drag_area.dropped_in_trash.connect(_on_dropped_in_trash)


func assign_quest(init_quest: Quest) -> void:
	if !init_quest:
		push_error("No quest assigned")
		return
	quest = init_quest
	quest.progressed.connect(_on_quest_progressed)
	quest.changed.connect(_on_quest_progressed)
	quest.completed.connect(_on_quest_completed)
	update_display()
	animation_player.play(POP_IN)


func update_display() -> void:
	if !quest:
		return
	quest_label.text = quest.text
	if quest.max_value == 0:
		quest_progress_bar.hide()
	quest_progress_bar.value = quest.value
	quest_progress_bar.max_value = quest.max_value


func mark_done() -> void:
	animation_player.play(MARK_DONE)


func remove() -> void:
	animation_player.play(POP_OUT)
	animation_player.animation_finished.connect(_on_animation_remove_finished)


func _on_animation_remove_finished(anim: String) -> void:
	queue_free()


func _on_quest_progressed() -> void:
	update_display()


func _on_quest_completed() -> void:
	mark_done()


func _on_dropped_in_trash(trash_bin: TrashBin) -> void:
	trash_bin.throw_animation()
	remove()


