extends Area2D

@export var CreditScene = preload("res://creditos.tscn") # tu escena de créditos
var jugador_cercano: Node = null
var creditos_instance: Node = null

func _ready():
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(body):
	if body is CharacterBody2D:
		jugador_cercano = body

func _on_body_exited(body):
	if body is CharacterBody2D and jugador_cercano == body:
		jugador_cercano = null

func _process(delta):
	if jugador_cercano and Input.is_action_just_pressed("ui_accept"):
		_mostrar_creditos()

func _mostrar_creditos():
	if creditos_instance != null and is_instance_valid(creditos_instance):
		return # evita instanciar varias veces

	# Pausar el juego
	get_tree().paused = true

	# Instanciar la escena de créditos
	creditos_instance = CreditScene.instantiate()
	get_tree().current_scene.add_child(creditos_instance)
