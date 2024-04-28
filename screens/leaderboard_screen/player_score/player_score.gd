class_name PlayerScore
extends HBoxContainer

@onready var player_position_label: Label = %PlayerPositionLabel
@onready var player_name_label: Label = %PlayerNameLabel
@onready var player_score_label: Label = %PlayerScoreLabel


func fill(position: int, name: String, score: int) -> void:
	player_position_label.text = str(position)
	player_name_label.text = name
	player_score_label.text = str(score)
