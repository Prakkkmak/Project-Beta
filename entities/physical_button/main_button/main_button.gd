class_name MainButton
extends RigidBody2D


signal pressed
signal released


@onready var clickable_component: ClickableComponent = $ClickableComponent


func _ready() -> void:
	clickable_component.pressed.connect(_on_pressed)
	clickable_component.released.connect(_on_released)


func _on_pressed() -> void:
	Score.change_score(1)
	pressed.emit()

func _on_released() -> void:
	released.emit()
