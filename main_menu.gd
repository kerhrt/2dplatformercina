extends CanvasLayer


func _on_play_pressed() -> void:
	$Control/VBoxContainer/Play/Label.text = str("Loading...")
	$Control/VBoxContainer/Play/AudioStreamPlayer2D.play()
	await $Control/VBoxContainer/Play/AudioStreamPlayer2D.finished
	get_tree().change_scene_to_file("res://Level1.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()
