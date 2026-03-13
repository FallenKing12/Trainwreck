extends Node2D


func _ready() -> void:
	pass


func _process(delta: float) -> void:
	$Sky.scroll_offset.x -= 10 * delta
	$Ground.scroll_offset.x -= 50 * delta
	$Trees.scroll_offset.x -= 100 * delta
	pass


func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://game/game.tscn")


func _on_quit_button_pressed() -> void:
	get_tree().quit(0)
