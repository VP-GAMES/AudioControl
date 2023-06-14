@tool
extends EditorPlugin

func _enter_tree():
	add_autoload_singleton("AudioControl", "res://addons/audio_control/AudioControl.gd")
	ProjectSettings.set_setting("audio/buses/default_bus_layout", "res://addons/audio_control/base_bus_layout.tres")

func _exit_tree():
	remove_autoload_singleton("AudioControl")
