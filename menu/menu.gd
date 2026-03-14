extends Node2D

@onready var cam = $Camera2D

@onready var start_but = $Start_button
@onready var quit_but = $Quit_button
@onready var test_but = $test_button

func _ready() -> void:
	cam.global_position = Vector2(576.0, 0.0)
	
	start_but.modulate.a = 0.0
	quit_but.modulate.a = 0.0
	test_but.modulate.a = 0.0
	
	start_but.disabled = true
	quit_but.disabled = true
	test_but.disabled = true

func _process(delta: float) -> void:
	if start_but.modulate.a == 1.0 and start_but.disabled:
		start_but.disabled = false
	if quit_but.modulate.a == 1.0 and quit_but.disabled:
		quit_but.disabled = false
	if test_but.modulate.a == 1.0 and test_but.disabled:
		test_but.disabled = false
	
	$Sky.scroll_offset.x -= 100.0 * delta
	$Ground.scroll_offset.x -= 500.0 * delta
	$Trees.scroll_offset.x -= 1000.0 * delta
	pass


func intro(skipped: bool) -> void:
	if skipped:
		cam.global_position = Vector2(576.0, 324.0)
		
		start_but.modulate.a = 1.0
		quit_but.modulate.a = 1.0
		test_but.modulate.a = 1.0
	else:
		var tween = create_tween()
		tween.tween_property(cam, "global_position:y", 324.0, 5.0)
		
		# когда будет поезд, сделать ещё сдвиг влево
	
		tween.tween_property(start_but, "modulate:a", 1, 0.3)
		quit_but.disabled = false
		tween.tween_property(quit_but, "modulate:a", 1, 0.3)
		test_but.disabled = false
		tween.tween_property(test_but, "modulate:a", 1, 0.3)


func _on_start_button_pressed() -> void:
	pass

func _on_test_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/test_scene/proc_gen_world.tscn")

func _on_quit_button_pressed() -> void:
	get_tree().quit(0)
