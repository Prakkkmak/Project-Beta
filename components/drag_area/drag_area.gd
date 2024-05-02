class_name DragArea
extends Area2D


signal dropped_in_trash(trash_bin: TrashBin)


@export var dragged_node: Node2D

var drag_delta: Vector2 = Vector2.ZERO
var drag: bool = false

var is_on_trash_zone: bool = false

func _ready() -> void:
	if !dragged_node:
		push_warning("No dragged node set")
		return
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	input_event.connect(_on_input_event)


func _input(event: InputEvent) -> void:
	if (event is InputEventMouseButton && event.is_released() && drag):
		drag = false
		var areas: Array[Area2D] = get_overlapping_areas()
		for area: Area2D in areas:
			if area is TrashBin:
				dropped_in_trash.emit(area as TrashBin)
		get_viewport().set_input_as_handled()

func _process(delta: float) -> void:
	if drag:
		dragged_node.global_position = get_global_mouse_position() + drag_delta


func _on_mouse_entered() -> void:
	Input.set_default_cursor_shape(Input.CURSOR_DRAG)


func _on_mouse_exited() -> void:
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if (event is InputEventMouseButton && event.is_pressed()):
		drag = true
		drag_delta = dragged_node.global_position - get_global_mouse_position()
		var parent: Node = owner.get_parent()
		parent.remove_child(owner)
		parent.add_child(owner)
		get_viewport().set_input_as_handled()




