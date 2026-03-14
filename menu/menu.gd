extends Node2D


func _ready() -> void:
	$Camera2D.global_position = Vector2(576.0, 0.0)
	
	$Start_button.modulate.a = 0.0
	$Quit_button.modulate.a = 0.0
	$test_button.modulate.a = 0.0
	
	$Start_button.disabled = true
	$Quit_button.disabled = true
	$test_button.disabled = true

func _process(delta: float) -> void:
	$Sky.scroll_offset.x -= 100 * delta
	$Ground.scroll_offset.x -= 500 * delta
	$Trees.scroll_offset.x -= 1000 * delta
	pass


func intro(skipped: bool) -> void:
	if skipped:
		$Camera2D.global_position = Vector2(576.0, 324.0)
		
		$Start_button.modulate.a = 1.0
		$Quit_button.modulate.a = 1.0
		$test_button.modulate.a = 1.0
		
		$Start_button.disabled = false
		$Quit_button.disabled = false
		$test_button.disabled = false
	else:
		var tween = create_tween()
		tween.tween_property($Camera2D, "global_position", Vector2(576.0, 324.0), 5.0)
		
		$Start_button.disabled = false
		tween.tween_property($Start_button, "modulate:a", 1, 1.0)
		$Quit_button.disabled = false
		tween.tween_property($Quit_button, "modulate:a", 1, 1.0)
		$test_button.disabled = false
		tween.tween_property($test_button, "modulate:a", 1, 1.0)


func _on_start_button_pressed() -> void:
	pass

func _on_test_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/test_scene/proc_gen_world.tscn")

func _on_quit_button_pressed() -> void:
	get_tree().quit(0)
