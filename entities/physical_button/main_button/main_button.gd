class_name MainButton
extends RigidBody2D


signal pressed
signal released

@export var initial_cooldown: float = 0.5

@onready var clickable_component: ClickableComponent = $ClickableComponent
@onready var cooldown_timer: Timer = $CooldownTimer
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var auto_increment_timer: Timer = $AutoIncrementTimer


var cooldown_enabled: bool = true
var _broken_button: bool = false
var _auto_increment: bool = false


func _ready() -> void:
	clickable_component.pressed.connect(_on_pressed)
	clickable_component.released.connect(_on_released)
	cooldown_timer.timeout.connect(_on_cooldown_timer_timeout)
	cooldown_enabled = initial_cooldown != 0
	cooldown_timer.wait_time = initial_cooldown
	auto_increment_timer.timeout.connect(_on_auto_increment_timer_timeout)
	GlobalEvents.threshold_triggered.connect(_on_threshold_triggered)


func broke_button() -> void:
	_broken_button = true


func repair_button() -> void:
	_broken_button = false


func is_broken_button() -> bool:
	return _broken_button


func press_auto_increment() -> void:
	animation_player.play("press")
	Score.change_score(1)
	get_tree().create_timer(.5).timeout.connect(func() -> void: animation_player.play("release"))


func _on_pressed() -> void:
	if _broken_button || _auto_increment:
		return
	Score.change_score(1)
	pressed.emit()
	animation_player.play("press")
	if cooldown_enabled:
		clickable_component.enabled = false
		cooldown_timer.start()


func _on_released() -> void:
	if _broken_button || _auto_increment:
		return
	animation_player.play("release")
	released.emit()


func _on_cooldown_timer_timeout() -> void:
	clickable_component.enabled = true


func _on_auto_increment_timer_timeout() -> void:
	press_auto_increment()

func _on_threshold_triggered(event_treshold: EventThreshold) -> void:
	if event_treshold is ButtonCooldownEventThreshold:
		var button_cooldown_event_treshold: ButtonCooldownEventThreshold = event_treshold as ButtonCooldownEventThreshold
		if button_cooldown_event_treshold.cooldown == 0:
			cooldown_enabled = false
			cooldown_timer.stop()
		else:
			cooldown_enabled = true
			cooldown_timer.wait_time = button_cooldown_event_treshold.cooldown
			cooldown_timer.start()
	if event_treshold is CustomEventThreshold:
		var custom_event_treshold: CustomEventThreshold = event_treshold as CustomEventThreshold
		if custom_event_treshold.name == "auto_increment_enable":
			GlobalEvents.send_messages([
				"AUTO_INCREMENT_TXT_1",
				"AUTO_INCREMENT_TXT_2",
				"AUTO_INCREMENT_TXT_3"
			])
			_auto_increment = true
			auto_increment_timer.start()
		if custom_event_treshold.name == "auto_increment_disable":
			_auto_increment = false
			GlobalEvents.send_messages([
				"AUTO_INCREMENT_TXT_STOP_1",
				"AUTO_INCREMENT_TXT_STOP_2",
				"AUTO_INCREMENT_TXT_STOP_3"
			])
			auto_increment_timer.stop()
