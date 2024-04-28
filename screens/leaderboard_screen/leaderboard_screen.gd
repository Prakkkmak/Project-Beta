extends CanvasLayer

@export var base_url: String = "https://luxuriant-longhaired-silk.glitch.me"
@export var player_score_scene: PackedScene


@onready var http_request: HTTPRequest = $HTTPRequest
@onready var score_container: VBoxContainer = %ScoresContainer



func _ready() -> void:
	_load_leaderboard()


func _load_leaderboard() -> void:
	http_request.request(base_url + "/leaderboard")
	http_request.request_completed.connect(_on_request_completed)


func _on_request_completed(result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray) -> void:
	var json: Dictionary = JSON.parse_string(body.get_string_from_utf8())
	if json["success"] == false:
		push_warning("Error HTTP")
		return
	print(json)
	var data: Array = json["data"]
	for player_score: Dictionary in data:
		_add_player_score(player_score)

func _add_player_score(player_score: Dictionary) -> void:
	if !player_score_scene:
		return
	var new_player_score: PlayerScore = player_score_scene.instantiate() as PlayerScore
	score_container.add_child(new_player_score)
	var player_username: String = player_score["username"]
	var player_id: int = player_score["id"]
	var player_score_amount: int = player_score["score"]
	new_player_score.fill(player_id, player_username, player_score_amount)
	
