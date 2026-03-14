extends Control

@onready var cam = $"../Camera2D"
@onready var intro = $Intro

var skipped = false

func _ready() -> void:
	intro.modulate.a = 0
	self.modulate.a = 1

	var tween = create_tween()

	tween.tween_property(intro, "modulate:a", 1.0, 1.5)

	tween.tween_interval(4.0)

	tween.tween_property(intro, "modulate:a", 0.0, 1.0)
	tween.tween_property(self, "modulate:a", 0.0, 1.5)

func _process(delta: float) -> void:
	if Input.is_anything_pressed() or self.modulate.a == 0:
		queue_free()
		if self.modulate.a != 0:
			skipped = true
		
		get_parent().intro(skipped)
