extends Marker2D

@onready var audio_player_button: TextureButton = %AudioPlayerButton
@onready var music_audio_stream_player: AudioStreamPlayer = %MusicAudioStreamPlayer

func _ready() -> void:
	audio_player_button.toggled.connect(_on_audio_player_button_toggled)

func _on_audio_player_button_toggled(is_toggled: bool) -> void:
	if is_toggled:
		if music_audio_stream_player.stream_paused:
			music_audio_stream_player.stream_paused = false
		else:
			music_audio_stream_player.play()
	else:
		music_audio_stream_player.stream_paused = true
