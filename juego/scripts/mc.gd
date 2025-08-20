extends CharacterBody2D

var speed = 200
var npc_cercano = null  # NPC cercano con el que se puede interactuar

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

	# Movimiento
	velocity = dir * speed
	move_and_slide()

	# Ahora
	if Input.is_action_just_pressed("ui_accept") and npc_cercano:
		print("Enter presionado cerca de NPC") #debug
		npc_cercano.interactuar()  # llama a la función correcta del NPC
