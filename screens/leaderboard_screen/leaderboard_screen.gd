extends CanvasLayer

@export var base_url: String = "https://luxuriant-longhaired-silk.glitch.me"
@export var player_score_scene: PlayerScore


@onready var http_request: HTTPRequest = $HTTPRequest


func _ready() -> void:
	_load_leaderboard()


func _load_leaderboard() -> void:
	http_request.request(base_url + "/leaderboard")
	http_request.request_completed.connect(_on_request_completed)


func _on_request_completed(result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray) -> void:
	print(JSON.parse_string(body.get_string_from_utf8()))
