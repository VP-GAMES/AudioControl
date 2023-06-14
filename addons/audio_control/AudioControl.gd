extends Node

enum AudioBus { Master, Music, Effects }

var _save_path_audio_control = "user://audio_control.tres"
var _audio_data = AudioControlData.new()
var _audio_data_changed = false

func _init():
	for bus_key in AudioBus.keys():
		_audio_data.data[bus_key] = 0

func _ready():
	_load()
	_load_bus_volumes()

func _load() -> void:
	if FileAccess.file_exists(_save_path_audio_control):
		var loaded_audio_data = load(_save_path_audio_control)
		if loaded_audio_data != null:
			_audio_data = loaded_audio_data
			print(_audio_data)

func _load_bus_volumes() -> void:
	for bus_key in AudioBus.keys():
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index(bus_key), _audio_data.data[bus_key])

func save() -> void:
	var state = ResourceSaver.save(_audio_data, _save_path_audio_control)
	if state == OK:
		_audio_data_changed = false
	else:
		push_error("Can't save audio data")

# Master
func set_master_bus_volume_db(volume_db: float) -> void:
	_set_volume_db(AudioBus.Master, volume_db)

func set_master_bus_volume_linear(volume: float) -> void:
	_set_volume_db(AudioBus.Master, linear_to_db(volume))

func get_master_bus_volume_db() -> float:
	return _get_volume_db(AudioBus.Master)

func get_master_bus_volume_linear() -> float:
	return _get_volume_linear(AudioBus.Master)

# Music
func set_music_bus_volume_db(volume_db: float) -> void:
	_set_volume_db(AudioBus.Music, volume_db)

func set_music_bus_volume_linear(volume: float) -> void:
	_set_volume_db(AudioBus.Music, linear_to_db(volume))

func get_music_bus_volume_db() -> float:
	return _get_volume_db(AudioBus.Music)

func get_music_bus_volume_linear() -> float:
	return _get_volume_linear(AudioBus.Music)

# Effects
func set_effects_bus_volume_db(volume_db: float) -> void:
	_set_volume_db(AudioBus.Effects, volume_db)

func set_effects_bus_volume_linear(volume: float) -> void:
	_set_volume_db(AudioBus.Effects, linear_to_db(volume))

func get_effects_bus_volume_db() -> float:
	return _get_volume_db(AudioBus.Effects)

func get_effects_bus_volume_linear() -> float:
	return _get_volume_linear(AudioBus.Effects)

func _set_volume_db(bus: AudioBus, volume_db: float) -> void:
	_audio_data.data[_get_bus_key(bus)] = volume_db
	_audio_data_changed = true
	AudioServer.set_bus_volume_db(_get_bus_index(bus), volume_db)

func _get_volume_db(bus: AudioBus) -> float:
	return AudioServer.get_bus_volume_db(_get_bus_index(bus))

func _get_volume_linear(bus: AudioBus) -> float:
	return db_to_linear(_get_volume_db(bus))

func _get_bus_key(bus: AudioBus) -> String:
	return AudioBus.keys()[bus]

func _get_bus_index(bus: AudioBus) -> int:
	return AudioServer.get_bus_index(_get_bus_key(bus))

