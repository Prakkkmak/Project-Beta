@tool
class_name PhysicalButton
extends RigidBody2D

signal pressed
signal released

@export var normal_texture: Texture
@export var pressed_texture: Texture

@onready var sprite: Sprite2D = $Sprite


func _ready() -> void:
	print("ready")
	sprite.texture = normal_texture
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	input_event.connect(_on_input_event)


func _on_mouse_entered() -> void:
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)


func _on_mouse_exited() -> void:
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if (event is InputEventMouseButton && event.is_pressed()):
		sprite.texture = pressed_texture
		pressed.emit()
	if (event is InputEventMouseButton && event.is_released()):
		sprite.texture = normal_texture
		released.emit()
