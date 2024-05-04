extends Node


@export var buttons: Array[TextureButton] = []


@onready var shadow: PointLight2D = %Shadow
@onready var text_light: PointLight2D = %TextLight
@onready var light_animation_player: AnimationPlayer = %LightAnimationPlayer
@onready var torch: PointLight2D = %Torch

func _ready() -> void:
	GlobalEvents.threshold_triggered.connect(_on_threshold_triggered)


func spawn_buttons() -> void:
	for button: TextureButton in buttons:
		button.show()
		button.pressed.connect(_on_light_button_pressed)
	GlobalEvents.send_messages([
		"C'est bon c'est réussi !",
		"Pour remettre le courant, il y a quelques boutons à trouver."
	])


func switch_off_lights() -> void:
	light_animation_player.play("light_off")
	GlobalEvents.send_messages([
		"On a un petit problème technique..",
		"Merde !",
		"Foutue lumière...",
		"J'ai réussi à mettre le courant de secours",
		"Je vais tenter de trouver une solution..."
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
			"Bien joué !",
			"                                       ",
			"Tu vas pouvoir continuer à cliquer sur le bouton.",
		])
		for button: TextureButton in buttons:
			button.hide()
			button.pressed.disconnect(_on_light_button_pressed)
