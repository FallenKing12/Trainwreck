extends CharacterBody2D


@onready var player_animation = $AnimatedSprite2D


var speed = 3000.0


func _ready() -> void:
	player_animation.play("default")


func _physics_process(delta: float) -> void:
	var direction_x := Input.get_axis("ui_left", "ui_right")
	var direction_y := Input.get_axis("ui_up", "ui_down")
	
	var mult = 1 # коэффициент для той же скорости при движении вбок
	if direction_x * direction_y != 0:
		mult = 1.4142 # sqrt(2)
	
	if direction_x:
		velocity.x = direction_x / mult * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
	if direction_y:
		velocity.y = direction_y / mult * speed 
	else:
		velocity.y = move_toward(velocity.y, 0, speed)

	move_and_slide()


func update_deleloper_mode(dev_mode: bool):
	var cam = get_node("Camera2D")
	if dev_mode:
		speed = 3000.0
		cam.zoom.x = 0.13;
		cam.zoom.y = 0.13;
	else:
		speed = 500.0
		cam.zoom.x = 0.5;
		cam.zoom.y = 0.5;
