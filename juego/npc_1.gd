extends StaticBody2D

@export var nombre = "NPC"
@export var dialogo = "¡Hola! Soy un personaje."

var jugador_cercano = null  # Guarda el jugador que está cerca
var DialogueScene = preload("res://npc1_dialogue_box.tscn") # Ajusta la ruta a tu escena real

func _ready():
	$AnimatedSprite2D.play("default")
	
	# Conecta las señales del Area2D hijo
	$Area2D.body_entered.connect(_on_body_entered)
	$Area2D.body_exited.connect(_on_body_exited)

func _on_body_entered(body):
	if body.name == "Jugador":
		jugador_cercano = body
		jugador_cercano.npc_cercano = self

func _on_body_exited(body):
	if body.name == "Jugador":
		jugador_cercano = null
		body.npc_cercano = null

func mostrar_dialogo():
	# Instanciamos la escena de diálogo
	var dialogue_instance = DialogueScene.instantiate()
	
	# Si tu escena de diálogo tiene un método para setear texto/personaje:
	if dialogue_instance.has_method("mostrar_dialogo"):
		dialogue_instance.mostrar_dialogo(dialogo, nombre)

	# Añadirla a la escena actual (normalmente al root de gameplay)
	get_tree().current_scene.add_child(dialogue_instance)
