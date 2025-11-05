extends AnimatedSprite2D

func _trigger_animation(velocity: Vector2, direction: int):
	
	if direction < 0:
		flip_h = true
	elif direction > 0:
		flip_h = false
	
	if not get_parent().is_on_floor():
		play("julia_jump")
	elif velocity.x !=0:
		play("julia_run")
	else:
		play("julia_idle")
