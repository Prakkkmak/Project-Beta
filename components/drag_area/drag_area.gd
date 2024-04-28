class_name DragArea
extends Area2D


@export var dragged_node: Node2D

var drag_delta: Vector2 = Vector2.ZERO
var drag: bool = false

func _ready() -> void:
	if !dragged_node:
		push_warning("No dragged node set")
		return
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	input_event.connect(_on_input_event)


func _process(delta: float) -> void:
	if drag:
		print("++")
		dragged_node.global_position = get_global_mouse_position() + drag_delta


func _on_mouse_entered() -> void:
	print("entered")
	Input.set_default_cursor_shape(Input.CURSOR_DRAG)


func _on_mouse_exited() -> void:
	print("exited")
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	print("input for drag")
	if (event is InputEventMouseButton && event.is_pressed()):
		print("drag")
		drag = true
		drag_delta = dragged_node.global_position - get_global_mouse_position()
	if (event is InputEventMouseButton && event.is_released()):
		print("stop drage")
		drag = false
