@tool
class_name ClickableComponent
extends Node

signal pressed
signal released

@export var collision_object: CollisionObject2D
@export var sprite: Sprite2D
@export var normal_texture: Texture
@export var pressed_texture: Texture

var enabled: bool = true

func _ready() -> void:
	if !collision_object:
		return
	sprite.texture = normal_texture
	collision_object.mouse_entered.connect(_on_mouse_entered)
	collision_object.mouse_exited.connect(_on_mouse_exited)
	collision_object.input_event.connect(_on_input_event)


func _on_mouse_entered() -> void:
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)


func _on_mouse_exited() -> void:
	sprite.texture = normal_texture
	released.emit()
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if (event is InputEventMouseButton && event.is_pressed()):
		if !enabled:
			return
		sprite.texture = pressed_texture
		pressed.emit()
	if (event is InputEventMouseButton && event.is_released()):
		sprite.texture = normal_texture
		released.emit()
