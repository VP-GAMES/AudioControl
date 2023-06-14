extends Control

@onready var hSliderMaster: HSlider = $VBoxContainer/GridContainerMaster/HSliderMaster
@onready var hSliderMusic: HSlider = $VBoxContainer/GridContainerMusic/HSliderMusic
@onready var hSliderEffects: HSlider = $VBoxContainer/GridContainerEffects/HSliderEffects

@onready var buttonPlayMusic: Button = $VBoxContainer/ButtonPlayMusic
@onready var buttonPlayEffects: Button = $VBoxContainer/ButtonPlayEffect
@onready var buttonSave: Button = $VBoxContainer/ButtonSave

@onready var audioStreamPlayerMusic: AudioStreamPlayer = $AudioStreamPlayerMusic
@onready var audioStreamPlayerEffects: AudioStreamPlayer = $AudioStreamPlayerEffects

func _ready():
	hSliderMaster.value = AudioControl.get_master_bus_volume_linear()
	hSliderMusic.value = AudioControl.get_music_bus_volume_linear()
	hSliderEffects.value = AudioControl.get_effects_bus_volume_linear()

	hSliderMaster.value_changed.connect(_on_slider_master_value_changed)
	hSliderMusic.value_changed.connect(_on_slider_music_value_changed)
	hSliderEffects.value_changed.connect(_on_slider_effects_value_changed)
	
	buttonPlayMusic.pressed.connect(_on_play_music_pressed)
	buttonPlayEffects.pressed.connect(_on_play_effect_pressed)
	buttonSave.pressed.connect(_on_save_pressed)

func _on_slider_master_value_changed(value) -> void:
	AudioControl.set_master_bus_volume_linear(value)

func _on_slider_music_value_changed(value) -> void:
	AudioControl.set_music_bus_volume_linear(value)

func _on_slider_effects_value_changed(value) -> void:
	AudioControl.set_effects_bus_volume_linear(value)

func _on_play_music_pressed() -> void:
	if buttonPlayMusic.button_pressed:
		audioStreamPlayerMusic.play()
	else:
		audioStreamPlayerMusic.stop()

func _on_play_effect_pressed() -> void:
	if buttonPlayEffects.button_pressed:
		audioStreamPlayerEffects.play()
	else:
		audioStreamPlayerEffects.stop()

func _on_save_pressed() -> void:
	AudioControl.save()
