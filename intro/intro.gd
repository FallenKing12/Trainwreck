extends Control

@onready var cam = $"../Camera2D"

var skipped = false

func _ready() -> void:
	$Intro.modulate.a = 0
	self.modulate.a = 1

	var tween = create_tween()

	tween.tween_property($Intro, "modulate:a", 1.0, 1.5)

	tween.tween_interval(4.0)

	tween.tween_property($Intro, "modulate:a", 0.0, 1.0)
	tween.tween_property(self, "modulate:a", 0.0, 1.0)

func _process(delta: float) -> void:
	global_position = cam.global_position - Vector2(576.0, 324.0)
	$Intro.global_position = global_position + Vector2(576.0, 324.0)
	
	if Input.is_anything_pressed() or self.modulate.a == 0:
		queue_free()
		if self.modulate.a != 0:
			skipped = true
		
		var menu = get_parent()
		menu.intro(skipped)
