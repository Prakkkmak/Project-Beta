@tool
class_name ClickableComponent
extends Node

signal pressed
signal released

@export var collision_object: CollisionObject2D

var enabled: bool = true
var is_pressed: bool = false

func _ready() -> void:
	if !collision_object:
		return
	collision_object.mouse_entered.connect(_on_mouse_entered)
	collision_object.mouse_exited.connect(_on_mouse_exited)
	collision_object.input_event.connect(_on_input_event)


func _on_mouse_entered() -> void:
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)


func _on_mouse_exited() -> void:
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)
	if !is_pressed:
		return
	released.emit()
	is_pressed = false


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if (event is InputEventMouseButton && event.is_pressed()):
		if !enabled:
			print("disabled can't press")
			return
		is_pressed = true
		pressed.emit()
	if (event is InputEventMouseButton && event.is_released()):
		if is_pressed:
			released.emit()
			is_pressed = false
