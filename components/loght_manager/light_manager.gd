extends Node


@export var buttons: Array[TextureButton] = []


@onready var shadow: PointLight2D = %Shadow
@onready var text_light: PointLight2D = %TextLight
@onready var light_animation_player: AnimationPlayer = %LightAnimationPlayer
@onready var torch: PointLight2D = %Torch

func _ready() -> void:
	GlobalEvents.threshold_triggered.connect(_on_threshold_triggered)


func _process(delta: float) -> void:
	torch.global_position = torch.get_global_mouse_position()


func spawn_buttons() -> void:
	for button: TextureButton in buttons:
		button.show()
		button.pressed.connect(_on_light_button_pressed)
	GlobalEvents.send_messages([
		"SPAWN_BUTTON_LIGHT_TXT_1",
		"SPAWN_BUTTON_LIGHT_TXT_2"
	])


func switch_off_lights() -> void:
	light_animation_player.play("light_off")
	GlobalEvents.send_messages([
		"SWITCH_OFF_LIGHT_TXT_1",
		"SWITCH_OFF_LIGHT_TXT_2",
		"SWITCH_OFF_LIGHT_TXT_3",
		"SWITCH_OFF_LIGHT_TXT_4",
		"SWITCH_OFF_LIGHT_TXT_5",
		"SWITCH_OFF_LIGHT_TXT_6"
	])


func _on_threshold_triggered(event_treshold: EventThreshold) -> void:
	if !(event_treshold is CustomEventThreshold):
		return
	var custom_event_treshold: CustomEventThreshold = event_treshold as CustomEventThreshold
	if custom_event_treshold.name == "light_off":
		switch_off_lights()
	if custom_event_treshold.name == "light_buttons":
		spawn_buttons()


func _on_light_button_pressed() -> void:
	var all_pressed: bool = buttons.all(func(elem: TextureButton) -> bool: return elem.button_pressed)
	if all_pressed:
		light_animation_player.play("light_on")
		GlobalEvents.send_messages([
			"LIGHT_BUTTTON_PRESSED_TXT_1",
			"LIGHT_BUTTTON_PRESSED_TXT_2",
			"LIGHT_BUTTTON_PRESSED_TXT_3",
		])
		for button: TextureButton in buttons:
			button.hide()
			button.pressed.disconnect(_on_light_button_pressed)
