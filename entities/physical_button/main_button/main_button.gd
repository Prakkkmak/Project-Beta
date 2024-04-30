class_name MainButton
extends RigidBody2D


signal pressed
signal released

@export var initial_cooldown: float = 0.5

@onready var clickable_component: ClickableComponent = $ClickableComponent
@onready var cooldown_timer: Timer = $CooldownTimer
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var cooldown_enabled: bool = true


func _ready() -> void:
	clickable_component.pressed.connect(_on_pressed)
	clickable_component.released.connect(_on_released)
	cooldown_timer.timeout.connect(_on_cooldown_timer_timeout)
	cooldown_enabled = initial_cooldown != 0
	cooldown_timer.wait_time = initial_cooldown
	GlobalEvents.threshold_triggered.connect(_on_threshold_triggered)


func _on_pressed() -> void:
	Score.change_score(1)
	pressed.emit()
	animation_player.play("press")
	if cooldown_enabled:
		clickable_component.enabled = false
		cooldown_timer.start()

func _on_released() -> void:
	animation_player.play("release")
	released.emit()

func _on_cooldown_timer_timeout() -> void:
	clickable_component.enabled = true


func _on_threshold_triggered(event_treshold: EventThreshold) -> void:
	if !(event_treshold is  ButtonCooldownEventThreshold):
		return
	var button_cooldown_event_treshold: ButtonCooldownEventThreshold = event_treshold as ButtonCooldownEventThreshold
	if button_cooldown_event_treshold.cooldown == 0:
		cooldown_enabled = false
		cooldown_timer.stop()
	else:
		cooldown_enabled = true
		cooldown_timer.wait_time = button_cooldown_event_treshold.cooldown
		cooldown_timer.start()
