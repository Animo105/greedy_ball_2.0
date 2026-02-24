extends Control


func _on_quitt_pressed() -> void:
	get_tree().quit()


func _on_tests_pressed() -> void:
	get_tree().change_scene_to_file("res://Tests/test_area.tscn")


func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://Levels/level_1.tscn")
