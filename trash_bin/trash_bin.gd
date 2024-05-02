class_name TrashBin
extends Area2D

@export var bin_closed_texture: Texture
@export var bin_opened_texture: Texture


@onready var sprite: Sprite2D = %Sprite2D
@onready var animation_player: AnimationPlayer = %AnimationPlayer


func _ready() -> void:
	area_entered.connect(_on_area_entered)
	area_exited.connect(_on_area_exited)
	if bin_closed_texture:
		sprite.texture = bin_closed_texture


func throw_animation() -> void:
	animation_player.play("throw")


func _on_area_entered(area: Area2D) -> void:
	if bin_opened_texture:
		sprite.texture = bin_opened_texture


func _on_area_exited(area: Area2D) -> void:
	if bin_closed_texture:
		sprite.texture = bin_closed_texture
