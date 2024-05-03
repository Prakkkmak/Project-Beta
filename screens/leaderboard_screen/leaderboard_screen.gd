extends CanvasLayer

@export var player_score_scene: PackedScene
@onready var score_container: VBoxContainer = %ScoresContainer

func _ready() -> void:
	_add_player_scores()
	Leaderboard.player_scores_loaded.connect(_on_player_scores_loaded)

func _add_player_scores() -> void:
	for player_score: Dictionary in Leaderboard.player_scores_sorted:
		var new_player_score: PlayerScore = player_score_scene.instantiate() as PlayerScore
		score_container.add_child(new_player_score)
		var player_position: int = player_score["position"]
		var player_username: String = player_score["username"]
		var player_score_amount: int = player_score["score"]
		new_player_score.fill(player_position, player_username, player_score_amount)


func _on_player_scores_loaded() -> void:
	for node: Node in score_container.get_children():
		score_container.remove_child(node)
		node.queue_free()
	_add_player_scores()
