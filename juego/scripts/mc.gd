extends CharacterBody2D

var speed = 200

func _physics_process(delta):
	var dir = Vector2.ZERO
	dir.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	dir.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")

	# Voltear horizontalmente si se mueve a izquierda o derecha
	if dir.x > 0:
		$Sprite2D.flip_h = false
	elif dir.x < 0:
		$Sprite2D.flip_h = true

	# Animaciones
	if dir != Vector2.ZERO:
		dir = dir.normalized()
		$Sprite2D.play("walk")  # nombre de animación
	else:
		$Sprite2D.play("default")

	velocity = dir * speed
	move_and_slide()
