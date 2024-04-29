class_name MainButton
extends RigidBody2D


signal pressed
signal released

@export var cooldown: float = 0.5

@onready var clickable_component: ClickableComponent = $ClickableComponent
@onready var cooldown_timer: Timer = $CooldownTimer


func _ready() -> void:
	clickable_component.pressed.connect(_on_pressed)
	clickable_component.released.connect(_on_released)
	cooldown_timer.timeout.connect(_on_cooldown_timer_timeout)
	cooldown_timer.wait_time = cooldown


func _on_pressed() -> void:
	Score.change_score(1)
	pressed.emit()
	clickable_component.enabled = false
	cooldown_timer.start()

func _on_released() -> void:
	released.emit()

func _on_cooldown_timer_timeout() -> void:
	print("timeout")
	clickable_component.enabled = true
