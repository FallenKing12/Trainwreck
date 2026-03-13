extends Node2D

var train_speed = 500

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$ground.scroll_offset.y += train_speed * delta
