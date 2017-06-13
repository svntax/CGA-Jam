
extends VBoxContainer

func _ready():
	pass

func _on_StartButton_pressed():
	var musicHandler = get_node("/root/music_handler")
	if(!musicHandler.is_playing()):
		musicHandler.play()

	get_tree().change_scene("res://gameplay.tscn")

func _on_QuitButton_pressed():
	get_tree().quit()
