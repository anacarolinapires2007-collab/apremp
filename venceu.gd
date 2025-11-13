extends Control
const MAIN_SCENE_PATH = "res://main.tscn"
const MENU_SCENE_PATH = "res://menu.tscn"



func _on_sair_pressed() -> void:
	get_tree().quit()


func _on_reiniciar_pressed() -> void:
	get_tree().change_scene_to_file(MAIN_SCENE_PATH)
