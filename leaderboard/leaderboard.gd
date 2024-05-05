extends Node


signal player_scores_loaded
signal player_score_added


const BASE_URL: String = "https://luxuriant-longhaired-silk.glitch.me"

@onready var http_request_post_score: HTTPRequest = $HTTPRequestPostScore
@onready var http_request_get_leaderboard: HTTPRequest = $HTTPRequestGetLeaderboard

var current_name: String = ""
var player_scores_sorted: Array[Dictionary] = []

func _ready() -> void:
	load_leaderboard()

func load_leaderboard() -> void:
	print("load leaderboard..")
	http_request_get_leaderboard.request(BASE_URL + "/leaderboard")
	http_request_get_leaderboard.request_completed.connect(_on_request_completed)

func push_new_score(score: int, username: String = "") -> void:
	print("Try to push the socre of " + username)
	if !username:
		print("No username so let's do " + current_name)
		username = current_name
	var body: String  = JSON.new().stringify({"username": username, "score": score})
	var headers: PackedStringArray = ["Content-Type: application/json"]
	http_request_post_score.request(BASE_URL + "/submit-score", headers, HTTPClient.METHOD_POST, body)
	http_request_post_score.request_completed.connect(_on_score_submitted)

func set_current_name(new_name: String) -> void:
	if current_name.is_empty():
		return
	current_name = new_name


func _on_score_submitted(result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray) -> void:
	print("response " + str(response_code))
	player_score_added.emit()
	load_leaderboard()

func _on_request_completed(result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray) -> void:
	var json: Dictionary = JSON.parse_string(body.get_string_from_utf8())
	if json["success"] == false:
		push_warning("Error HTTP")
		return
	print(json)
	var res: Array = json["data"]
	player_scores_sorted = []
	for e: Dictionary in res:
		player_scores_sorted.append(e)
	sort_and_assign_positions()
	print("Leaderboard loaded")
	player_scores_loaded.emit()

# Reused function to sort scores and assign positions
func sort_and_assign_positions() -> void:
	player_scores_sorted.sort_custom(sort_scores)
	for i: int in range(player_scores_sorted.size()):
		player_scores_sorted[i]["position"] = i + 1

# Custom sort function to sort dictionaries by 'score' key in descending order
func sort_scores(a: Dictionary, b: Dictionary) -> bool:
	return a["score"] > b["score"]
