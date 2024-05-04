extends CanvasLayer

@export_file("*.tscn") var title_screen_file_path: String = "res://screens/title_screen/title_screen.tscn"

@export var player_score_scene: PackedScene
@onready var score_container: VBoxContainer = %ScoresContainer
@onready var main_menu_button: TextureButton = %MainMenuButton

func _ready() -> void:
	_add_player_scores()
	Leaderboard.player_scores_loaded.connect(_on_player_scores_loaded)
	main_menu_button.pressed.connect(_on_main_menu_button_pressed)

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

func _on_main_menu_button_pressed() -> void:
	if !title_screen_file_path:
		push_warning("No end screen file path set")
		return
	get_tree().change_scene_to_file(title_screen_file_path)

